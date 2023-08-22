package defold.support;

#if macro
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using StringTools;
using haxe.macro.Tools;
using haxe.macro.TypeTools;
using haxe.macro.ExprTools;

private enum ScriptType {
    SNone;
    SCode;
    SGui;
    SRender;
}

private enum PropertyType {
    PBool;
    PInt;
    PFloat;
    PHash;
    PUrl;
    PVector3;
    PVector4;
    PQuaternion;
    PAtlasResourceReference;
    PFontResourceReference;
    PMaterialResourceReference;
    PTextureResourceReference;
    PTileSourceResourceReference;
    PBufferResourceReference;
}

private typedef ScriptExport = {
    var dir:String;
    var name:String;
    var position:String;
    var properties:Array<{name:String, value:String}>;
    var callbacks:Array<Callback>;
}

private typedef Callback = {
    var name: String;
    var method: String;
    var args: Array<String>;
    var isVoid: Bool;
}

private class Glue {
    static inline var EXPORT_TABLE = "_hxdefold_";

    var outDir:String;
    var requireModule:String;
    var scripts = new Array<ScriptExport>();

    // these will contain a map of callback method names
    var baseScriptMethods = new Map();
    var baseGuiScriptMethods = new Map();
    var baseRenderScriptMethods = new Map();

    public function new(outDir, requireModule) {
        this.outDir = outDir;
        this.requireModule = requireModule;
    }

    public function process(types:Array<ModuleType>) {
        // collect script classes
        var scriptClasses = [];

        for (type in types) {
            switch (type) {
                case TClassDecl(_.get() => cl):
                    switch (cl) {
                        case {pack: ["defold", "support"], name: "Script"}:
                            for (field in cl.fields.get())
                                baseScriptMethods[field.name] = true;

                        case {pack: ["defold", "support"], name: "GuiScript"}:
                            for (field in cl.fields.get())
                                baseGuiScriptMethods[field.name] = true;

                        case {pack: ["defold", "support"], name: "RenderScript"}:
                            for (field in cl.fields.get())
                                baseRenderScriptMethods[field.name] = true;

                        case {params: [tData]}: // Generic type in file, do nothing.

                        default:
                            switch getScriptType(cl) {
                                case SCode:
                                    scriptClasses.push({cls: cl, type: SCode});

                                case SGui:
                                    scriptClasses.push({cls: cl, type: SGui});

                                case SRender:
                                    scriptClasses.push({cls: cl, type: SRender});

                                default:
                            }
                    }
                default:
            }
        }

        // no script classes? nothing to do
        if (scriptClasses.length == 0)
            return;

        // this shouldn't happen at all
        if (baseScriptMethods == null)
            throw "No base Script class found!";

        // generate exports for our classes
        var initExprs = [];

        for (script in scriptClasses) {
            var cl = script.cls;

            // get data properties for generating `go.property` calls, which should be in the genrated script
            var props = getProperties(cl, cl.pos);
            props.sort(function(a,b) return a.order - b.order);

            var baseMethods, ext;
            switch (script.type) {
                case SCode:
                    baseMethods = baseScriptMethods;
                    ext = "script";
                case SGui:
                    baseMethods = baseGuiScriptMethods;
                    ext = "gui_script";
                case SRender:
                    baseMethods = baseRenderScriptMethods;
                    ext = "render_script";
                case SNone:
                    continue;
            }

            var exportExprs = [];
            var exportPrefix = (if (cl.pack.length == 0) cl.name else cl.pack.join("_") + "_" + cl.name) + "_";
            var callbacks = generateCallbacksRecursive(cl, exportExprs, exportPrefix, baseMethods);


            var tp = {
                var parts = cl.module.split(".");
                parts.unshift("std"); // because the init class is generated inside `defold.support`, we want to avoid Haxe to resolve package-less names to some defold.* type, so we append a magic `std` package
                var name = parts.pop();
                {pack: parts, name: name, sub: cl.name};
            }

            initExprs.push(macro @:privateAccess {
                var script = new $tp();
                $b{exportExprs};
            });

            // finally, save the generated script file, using the name of the class
            var scriptDir = Path.join([outDir].concat(cl.pack));
            var fileName = cl.name + "." + ext;

            scripts.push({
                properties: props,
                callbacks: callbacks,
                dir: scriptDir,
                name: fileName,
                position: {
                    var posStr = Std.string(cl.pos);
                    posStr.substring(5, posStr.length - 1);
                }
            });
        }

        var supportedDefoldVersion: String = haxe.macro.Context.definedValue('defold_version');
        initExprs.push(macro {
            var defoldVersion: String = untyped __lua__('sys.get_engine_info().version');
            var supportedDefoldVersion: String = $v{supportedDefoldVersion};
            if (defoldVersion != supportedDefoldVersion)
            {
                std.Sys.println('WARNING: the installed hxdefold version supports Defold $supportedDefoldVersion, but you are running $defoldVersion');
            }
        });

        if (initExprs.length > 0) {
            var td = macro class Init {
                static function init(exports:Dynamic) $b{initExprs};
                static function __init__() {
                    untyped __lua__($v{EXPORT_TABLE + " = " + EXPORT_TABLE + " or {}"});
                    init(untyped $i{EXPORT_TABLE});
                }
            };
            td.meta.push({name: ":keepInit", pos: td.pos});
            td.pack = ["defold", "support"];
            Context.defineType(td);
        }
    }

    public function generate() {
        // clear the scripts output directory
        deleteRec(outDir);
        sys.FileSystem.createDirectory(outDir);
        for (script in scripts) {
            var b = new StringBuf();

            // add a nice header
            b.add('-- Generated by Haxe, DO NOT EDIT (original source: ${script.position})\n\n');

            // if we have data properties, generate go.property calls for them
            // TODO: more work should be done to support all types of default values
            if (script.properties.length > 0) {
                for (prop in script.properties) {
                    b.add('go.property("${prop.name}", ${prop.value})\n');
                }
                b.add("\n");
            }

            // require the main generated lua file
            b.add('require "$requireModule"\n\n');

            for (cb in script.callbacks) {
                var callbackArgs = 'self';
                var methodCallArgs = cb.args.join(", ");
                var callbackArgs = if (methodCallArgs == '') 'self' else 'self, $methodCallArgs';

                var callbackName = callbackNameToSnakeCase(cb.name);

                b.add('
function ${callbackName}($callbackArgs)
    _hxdefold_tmp = ${ScriptBuilder.globalSelfRef}
    ${ScriptBuilder.globalSelfRef} = self
    ${if (cb.isVoid) "" else "ret = "}$EXPORT_TABLE.${cb.method}($methodCallArgs)
    ${ScriptBuilder.globalSelfRef} = _hxdefold_tmp
    ${if (cb.isVoid) "" else "return ret"}
end
');
            }

            sys.FileSystem.createDirectory(script.dir);
            sys.io.File.saveContent('${script.dir}/${script.name}', b.toString());
        }
    }


    function generateCallbacksRecursive(cl:ClassType, exportExprs:Array<Expr>, exportPrefix:String, baseMethods:Map<String,Bool>, callbackNames:Array<String> = null):Array<Callback> {
        if (isBaseScriptType(cl)) {
            // Reached the base script type, stop here.
            return [];
        }

        var callbacks:Array<Callback> = [];
        if (callbackNames == null) {
            callbackNames = [];
        }

        // generate callback fields
        for (field in cl.fields.get()) {
            // this is a callback field, if it's overriden from the base Script class
            var fieldName = field.name;
            if (!baseMethods.exists(fieldName)) {
                continue;
            }

            // in haxe 4, final is a keyword, so we need to handle this here
            // we could do it more elaborately via metadata or something, but oh well :)
            var callbackName = fieldName;

            if (callbackNames.indexOf(callbackName) > -1) {
                // This callback has already been defined by a previous call in the recursion.
                // i.e a type which extends cl has redefined this method.
                continue;
            }

            // generate arguments
            var argNames = [], funExpr, isVoid;
            switch (field.type) {
                case TFun(args, ret):
                    var argDefs = new Array<FunctionArg>();
                    var argExprs = [];

                    for (arg in args) {
                        argNames.push(arg.name);
                        argDefs.push({name: arg.name, type: macro : Dynamic});
                        argExprs.push(macro $i{arg.name});
                    }

                    isVoid = ret.toString() == "Void";

                    var expr = macro script.$fieldName($a{argExprs});
                    if (!isVoid) expr = macro return $expr;

                    funExpr = {
                        pos: field.pos,
                        expr: EFunction(null, {
                            args: argDefs,
                            ret: null,
                            expr: expr
                        })
                    };
                default:
                    Context.fatalError("Overriden class field is not a method. This can't happen! :)", field.pos);
            }

            var exportName = exportPrefix + fieldName;
            exportExprs.push(macro exports.$exportName = $funExpr);

            callbackNames.push(callbackName);

            // generate callback function definition
            callbacks.push({
                name: callbackName,
                method: exportName,
                args: argNames,
                isVoid: isVoid,
            });
        }

        if (cl.superClass != null)
        {
            callbacks = callbacks.concat(generateCallbacksRecursive(cl.superClass.t.get(), exportExprs, exportPrefix, baseMethods, callbackNames));
        }

        return callbacks;
    }

    // this should really be in the standard library
    static function deleteRec(path:String) {
        if (!sys.FileSystem.exists(path))
            return;
        if (sys.FileSystem.isDirectory(path)) {
            for (file in sys.FileSystem.readDirectory(path))
                deleteRec('$path/$file');
            sys.FileSystem.deleteDirectory(path);
        } else {
            sys.FileSystem.deleteFile(path);
        }
    }

    static function getProperties(cls:ClassType, pos:Position):Array<{name:String, value:String, order:Int}> {
        var properties = [];

        // recursively add the properties from all parent classes
        if (cls.superClass != null)
        {
            properties = properties.concat(getProperties(cls.superClass.t.get(), pos));
        }

        for (field in cls.fields.get())
        {
            switch field.kind
            {
                case FVar(read, write):
                    var prop = field.meta.extract("property");
                    switch (prop)
                    {
                        case [] | null:
                            // not a property

                        case [prop]:
                            var type = getPropertyType(field.type, field.pos);
                            var value = if (prop.params.length == 0) getDefaultValue(type) else parsePropertyExpr(type, prop.params, prop.pos);
                            var order = Context.getPosInfos(field.pos).min;
                            properties.push({name: field.name, value: value, order: order});

                        default:
                            Context.fatalError('only one @property tag is allowed on each field', pos);
                    }

                default:
                    // not a property
            }
        }

        return properties;
    }

    static function getPropertyType(type:Type, pos:Position):PropertyType
    {
        var actualType: Type = type.follow();

        return switch actualType
        {
            case TInst(_.get() => {pack: ["defold", "types"], name: "Hash"}, _): PHash;
            case TInst(_.get() => {pack: ["defold", "types"], name: "Url"}, _): PUrl;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "Vector3"}, _): PVector3;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "Vector4"}, _): PVector4;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "Quaternion"}, _): PQuaternion;
            case TAbstract(_.get() => {pack: [], name: "Int"}, _): PInt;
            case TAbstract(_.get() => {pack: [], name: "Float"}, _): PFloat;
            case TAbstract(_.get() => {pack: [], name: "Bool"}, _): PBool;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "AtlasResourceReference"}, _): PAtlasResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "FontResourceReference"}, _): PFontResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "MaterialResourceReference"}, _): PMaterialResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "TextureResourceReference"}, _): PTextureResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "TileSourceResourceReference"}, _): PTileSourceResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "BufferResourceReference"}, _): PBufferResourceReference;

            case TAbstract(_.get() => t, _):
                /**
                 * This recursive call allows the user to define abstracts over a property type,
                 * and then use those abstracts for properties!
                 */
                return getPropertyType(t.type, pos);

            default:
                /**
                 * We reached the final non-abstract type and didn't find any supported property type.
                 */
                Context.fatalError('Unsupported type for script property: ${type.toString()}', pos);
        }
    }

    static function getDefaultValue(type:PropertyType):String {
        return switch (type) {
            case PHash: 'hash("")';
            case PUrl: 'msg.url()';
            case PVector3: 'vmath.vector3()';
            case PVector4: 'vmath.vector4()';
            case PBool: 'false';
            case PInt: '0';
            case PFloat: '0.0';
            case PQuaternion: 'vmath.quat()';
            case PAtlasResourceReference: 'resource.atlas()';
            case PFontResourceReference: 'resource.font()';
            case PMaterialResourceReference: 'resource.material()';
            case PTextureResourceReference: 'resource.texture()';
            case PTileSourceResourceReference: 'resource.tile_source()';
            case PBufferResourceReference: 'resource.buffer()';
        }
    }

    static function parsePropertyExpr(type:PropertyType, exprs:Array<Expr>, pos:Position):String {
        return switch [type, exprs] {

            case [PHash, [{expr: EConst(CString(s))}]]
               | [PHash, [{expr: ECall(macro hash, [{expr: EConst(CString(s))}])}]]
               | [PHash, [{expr: ECall(macro Defold.hash, [{expr: EConst(CString(s))}])}]]:
                'hash(${haxe.Json.stringify(s)})';

            case [PUrl, _]:
                Context.fatalError("No default value allowed for URL properties", pos);

            case [PFloat, [{expr: EConst(CFloat(s) | CInt(s))}]]:
                s;
            case [PInt, [{expr: EConst(CInt(s))}]] if (Std.parseInt(s) != null):
                s;
            case [PBool, [{expr: EConst(CIdent(s = "true" | "false"))}]]:
                s;

            case [PVector3, [{expr: ECall(macro vector3, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}])}]]
               | [PVector3, [{expr: ECall(macro Vmath.vector3, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}])}]]:
                'vmath.vector3($x, $y, $z)';
            case [PVector3, [{expr: ECall(macro vector3, [{expr: EConst(CFloat(n) | CInt(n))}]) }]]
               | [PVector3, [{expr: ECall(macro Vmath.vector3, [{expr: EConst(CFloat(n) | CInt(n))}]) }]]:
                'vmath.vector3($n)';
            case [PVector4, [{expr: ECall(macro vector4, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}, {expr: EConst(CFloat(w) | CInt(w))}])}]]
               | [PVector4, [{expr: ECall(macro Vmath.vector4, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}, {expr: EConst(CFloat(w) | CInt(w))}])}]]:
                'vmath.vector4($x, $y, $z, $w)';
            case [PVector4, [{expr: ECall(macro vector4, [{expr: EConst(CFloat(n) | CInt(n))}]) }]]
               | [PVector4, [{expr: ECall(macro Vmath.vector4, [{expr: EConst(CFloat(n) | CInt(n))}]) }]]:
                'vmath.vector4($n)';
            case [PQuaternion, [{expr: ECall(macro quat, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}, {expr: EConst(CFloat(w) | CInt(w))}])}]]
               | [PQuaternion, [{expr: ECall(macro Vmath.quat, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}, {expr: EConst(CFloat(w) | CInt(w))}])}]]:
                'vmath.quat($x, $y, $z, $w)';

            case [PAtlasResourceReference, [{expr: EConst(CString(s))}]]
               | [PAtlasResourceReference, [{expr: ECall(macro Resource.atlas, [{expr: EConst(CString(s))}])}]]:
                'resource.atlas(${haxe.Json.stringify(s)})';
            case [PFontResourceReference, [{expr: EConst(CString(s))}]]
               | [PFontResourceReference, [{expr: ECall(macro Resource.font, [{expr: EConst(CString(s))}])}]]:
                'resource.font(${haxe.Json.stringify(s)})';
            case [PMaterialResourceReference, [{expr: EConst(CString(s))}]]
               | [PMaterialResourceReference, [{expr: ECall(macro Resource.material, [{expr: EConst(CString(s))}])}]]:
                'resource.material(${haxe.Json.stringify(s)})';
            case [PTextureResourceReference, [{expr: EConst(CString(s))}]]
               | [PTextureResourceReference, [{expr: ECall(macro Resource.texture, [{expr: EConst(CString(s))}])}]]:
                'resource.texture(${haxe.Json.stringify(s)})';
            case [PTileSourceResourceReference, [{expr: EConst(CString(s))}]]
               | [PTileSourceResourceReference, [{expr: ECall(macro Resource.tileSource, [{expr: EConst(CString(s))}])}]]:
                'resource.tile_source(${haxe.Json.stringify(s)})';
            case [PBufferResourceReference, [{expr: EConst(CString(s))}]]
               | [PBufferResourceReference, [{expr: ECall(macro Resource.buffer, [{expr: EConst(CString(s))}])}]]:
                'resource.buffer(${haxe.Json.stringify(s)})';

            default:
                Context.fatalError('Invalid @property value for type ${type.getName().substr(1)}', pos);
        }
    }

    /**
        Checks the given class type `cl`, and its super classes recursively, to check if it is initially
        based on one of the `Script`, `GuiScript` or `RenderScript` types.

        @param cl The class type to check.
        @return The script type `cl` is extending, or `SNone` if it is not a script type.
    **/
    static function getScriptType(cl:ClassType):ScriptType {
        return switch (cl) {
            // Check if the base class is a type of script.
            case {superClass: {t: _.get() => {pack: ["defold", "support"], name: "Script"}}}:       SCode;
            case {superClass: {t: _.get() => {pack: ["defold", "support"], name: "GuiScript"}}}:    SGui;
            case {superClass: {t: _.get() => {pack: ["defold", "support"], name: "RenderScript"}}}: SRender;

            // If not, and it has a baseclass, check it recursively.
            case _ if (cl.superClass != null): getScriptType(cl.superClass.t.get());

            // Otherwise it's definitely not a script.
            default: SNone;
        }
    }

    /**
        Returns `true`, if the given class type `cl` is one of the base types `Script`, `GuiScript` or `RenderScript`.
    **/
    static function isBaseScriptType(cl:ClassType):Bool {
        return cl.pack.length == 2
            && cl.pack[0] == "defold"
            && cl.pack[1] == "support"
            && ["Script", "GuiScript", "RenderScript"].indexOf(cl.name) > -1;
    }

    static function callbackNameToSnakeCase(name:String):String {

        return switch name {
            case 'init': 'init';
            case 'final_': 'final';
            case 'update': 'update';
            case 'fixedUpdate': 'fixed_update';
            case 'onMessage': 'on_message';
            case 'onInput': 'on_input';
            case 'onReload': 'on_reload';
            default:
                Context.fatalError('invalid callback name: $name', Context.currentPos());
        }
    }
}

class ScriptMacro {

	static var generated:Bool = false;

    static function use() {
        if (!Context.defined("lua")) return; // run through `-lib hxdefold` for `haxelib run hxdefold`

		if (generated) {
			// script macro was called twice?
			// this can now happen as of Haxe 4.3 if a project has '-lib hxdefold` while also including
			// another library which has hxdefold as a dependency
			// not sure if it's a bug, or if it's normal now that extraParams.hxml can be added multiple times
			// for the same library
			return;
		}
		generated = true;

        var defoldRoot = Context.definedValue("hxdefold-projectroot");
        if (defoldRoot == null) defoldRoot = ".";

        var outDir = Context.definedValue("hxdefold-scriptdir");
        if (outDir == null) outDir = "scripts";

        defoldRoot = absolutePath(defoldRoot);
        if (!defoldRoot.endsWith("/"))
            defoldRoot += "/";
        var outFile = absolutePath(Compiler.getOutput());
        if (!StringTools.startsWith(outFile, defoldRoot)) {
            Context.fatalError("Haxe/Lua output file should be within specified defold project root (" + defoldRoot + "), but is " + outFile + ". Check -lua argument in your build hxml file.", Context.currentPos());
        }

        outDir = Path.join([defoldRoot, outDir]);

        // determine the the module name for the "require" statement,
        // based on main lua file path relative to defold project root
        var parts = outFile.substring(defoldRoot.length).split("/");
        var last = parts.length - 1;
        parts[last] = Path.withoutExtension(parts[last]);
        var requireModule = parts.join(".");

        var glue = new Glue(outDir, requireModule);

        var afterTypingCalled = false;
        Context.onAfterTyping(function(types) {
            if (afterTypingCalled) return;
            afterTypingCalled = true;
            glue.process(types);
        });

        Context.onAfterGenerate(glue.generate);
    }

    // sys.FileSystem.absolutePath is broken on Haxe 4, so we use the old method
    static function absolutePath(relPath:String):String {
        if (haxe.io.Path.isAbsolute(relPath)) return relPath;
        return haxe.io.Path.join([std.Sys.getCwd(), relPath]);
    }
}
#end
