package defold.support;

#if macro
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
using StringTools;
using haxe.macro.Tools;

private enum ScriptType {
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
}

private typedef ScriptExport = {
    var dir:String;
    var name:String;
    var position:String;
    var properties:Array<{name:String, value:String}>;
    var callbacks:Array<{name:String, method:String, args:Array<String>, isVoid:Bool}>;
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

                        case {superClass: {t: _.get() => {pack: ["defold", "support"], name: "Script"}, params: [tData]}}:
                            scriptClasses.push({cls: cl, data: tData, type: SCode});

                        case {superClass: {t: _.get() => {pack: ["defold", "support"], name: "GuiScript"}, params: [tData]}}:
                            scriptClasses.push({cls: cl, data: tData, type: SGui});

                        case {superClass: {t: _.get() => {pack: ["defold", "support"], name: "RenderScript"}, params: [tData]}}:
                            scriptClasses.push({cls: cl, data: tData, type: SRender});

                        default:
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
            var props = getProperties(script.data, cl.pos);
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
            }

            var exportExprs = [];
            var exportPrefix = (if (cl.pack.length == 0) cl.name else cl.pack.join("_") + "_" + cl.name) + "_";
            var callbacks = [];

            // generate callback fields
            for (field in cl.fields.get()) {
                // this is a callback field, if it's overriden from the base Script class
                var fieldName = field.name;
                if (baseMethods.exists(fieldName)) {
                    // in haxe 4, final is a keyword, so we need to handle this here
                    // we could do it more elaborately via metadata or something, but oh well :)
                    var callbackName = switch fieldName {
                        case "final_": "final";
                        case _: fieldName;
                    };

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
                            throw new Error("Overriden class field is not a method. This can't happen! :)", field.pos);
                    }

                    var exportName = exportPrefix + fieldName;
                    exportExprs.push(macro exports.$exportName = $funExpr);

                    // generate callback function definition
                    callbacks.push({
                        name: callbackName,
                        method: exportName,
                        args: argNames,
                        isVoid: isVoid,
                    });
                }
            }

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

            var scriptPackage = cl.pack;

            // Strip the root package from the beginning of the path.
            var rootPackage = Context.definedValue("hxdefold-rootpackage");
            if (rootPackage != null)
            {
                var rootPackageParts = rootPackage.split('.');

                for (i in 0...rootPackageParts.length)
                {
                    if (rootPackageParts[i] == scriptPackage[0])
                    {
                        scriptPackage = scriptPackage.slice(1);
                    }
                    else
                    {
                        // Script is not under the root package, exclude it.
                        continue;
                    }
                }
            }

            // finally, save the generated script file, using the name of the class
            var scriptDir = Path.join([outDir].concat(scriptPackage));
            var fileName = cl.name + "." + ext;

            scripts.push({
                properties: props,
                callbacks: callbacks,
                dir: scriptDir,
                name: fileName,
                position: {
                    var posStr = Std.string(cl.pos);
                    posStr.substring(5, posStr.length - 1);
                },
            });
        }

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
                var args = cb.args.join(", ");
                b.add('function ${cb.name}($args)\n\t${if (cb.isVoid) "" else "return "}$EXPORT_TABLE.${cb.method}($args)\nend\n\n');
            }

            sys.FileSystem.createDirectory(script.dir);
            sys.io.File.saveContent('${script.dir}/${script.name}', b.toString());
        }
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

    static function getProperties(type:Type, pos:Position):Array<{name:String, value:String, order:Int}> {
        var result = [];
        switch (type.follow()) {
            case TAnonymous(_.get() => anon):
                for (field in anon.fields) {
                    var prop = field.meta.extract("property");
                    switch (prop) {
                        case []:
                            continue;
                        case [prop]:
                            var type = getPropertyType(field.type, field.pos);
                            var value = if (prop.params.length == 0) getDefaultValue(type) else parsePropertyExpr(type, prop.params, prop.pos);
                            var order = Context.getPosInfos(field.pos).min;
                            result.push({name: field.name, value: value, order: order});
                        default:
                            throw new Error("Only single @property metadata is allowed", field.pos);
                    }
                }
            default:
                throw new Error('Invalid component data type: ${type.toString()}. Should be a structure.', pos);
        }
        return result;
    }

    static function getPropertyType(type:Type, pos:Position):PropertyType {
        return switch (type.follow()) {
            case TInst(_.get() => {pack: ["defold", "types"], name: "Hash"}, _): PHash;
            case TInst(_.get() => {pack: ["defold", "types"], name: "Url"}, _): PUrl;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "Vector3"}, _): PVector3;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "Vector4"}, _): PVector4;
            case TInst(_.get() => {pack: ["defold", "types"], name: "Quaternion"}, _): PQuaternion;
            case TAbstract(_.get() => {pack: [], name: "Int"}, _): PInt;
            case TAbstract(_.get() => {pack: [], name: "Float"}, _): PFloat;
            case TAbstract(_.get() => {pack: [], name: "Bool"}, _): PBool;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "AtlasResourceReference"}, _): PAtlasResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "FontResourceReference"}, _): PFontResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "MaterialResourceReference"}, _): PMaterialResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "TextureResourceReference"}, _): PTextureResourceReference;
            case TAbstract(_.get() => {pack: ["defold", "types"], name: "TileSourceResourceReference"}, _): PTileSourceResourceReference;
            default: throw new Error('Unsupported type for script property: ${type.toString()}', pos);
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
            case PAtlasResourceReference
                | PFontResourceReference
                | PMaterialResourceReference
                | PTextureResourceReference
                | PTileSourceResourceReference: throw new Error('Property of type ${Std.string(type).substr(1)} cannot have an empty value.', Context.currentPos());
        }
    }

    static function parsePropertyExpr(type:PropertyType, exprs:Array<Expr>, pos:Position):String {
        return switch [type, exprs] {
            case [PBool, [{expr: EConst(CIdent(s = "true" | "false"))}]]:
                s;
            case [PHash, [{expr: EConst(CString(s))}]]:
                'hash(${haxe.Json.stringify(s)})';
            case [PUrl, _]:
                throw new Error("No default value allowed for URL properties", pos);
            case [PFloat, [{expr: EConst(CFloat(s) | CInt(s))}]]:
                s;
            case [PInt, [{expr: EConst(CInt(s))}]] if (Std.parseInt(s) != null):
                s;
            case [PVector3, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}]]:
                'vmath.vector3($x, $y, $z)';
            case [PVector4, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}, {expr: EConst(CFloat(w) | CInt(w))}]]:
                'vmath.vector4($x, $y, $z, $w)';
            case [PQuaternion, [{expr: EConst(CFloat(x) | CInt(x))}, {expr: EConst(CFloat(y) | CInt(y))}, {expr: EConst(CFloat(z) | CInt(z))}, {expr: EConst(CFloat(w) | CInt(w))}]]:
                'vmath.quat($x, $y, $z, $w)';
            case [PAtlasResourceReference, [{expr: EConst(CString(s))}]]:
                'resource.atlas(${haxe.Json.stringify(s)})';
            case [PFontResourceReference, [{expr: EConst(CString(s))}]]:
                'resource.font(${haxe.Json.stringify(s)})';
            case [PMaterialResourceReference, [{expr: EConst(CString(s))}]]:
                'resource.material(${haxe.Json.stringify(s)})';
            case [PTextureResourceReference, [{expr: EConst(CString(s))}]]:
                'resource.texture(${haxe.Json.stringify(s)})';
            case [PTileSourceResourceReference, [{expr: EConst(CString(s))}]]:
                'resource.tile_source(${haxe.Json.stringify(s)})';

            default:
                throw new Error('Invalid @property value for type ${type.getName().substr(1)}', pos);
        }
    }
}

class ScriptMacro {
    static function use() {
        if (!Context.defined("lua")) return; // run through `-lib hxdefold` for `haxelib run hxdefold`

        var defoldRoot = Context.definedValue("hxdefold-projectroot");
        if (defoldRoot == null) defoldRoot = ".";

        var outDir = Context.definedValue("hxdefold-scriptdir");
        if (outDir == null) outDir = "scripts";

        defoldRoot = absolutePath(defoldRoot);
        if (!defoldRoot.endsWith("/"))
            defoldRoot += "/";
        var outFile = absolutePath(Compiler.getOutput());
        if (!StringTools.startsWith(outFile, defoldRoot)) {
            throw new Error("Haxe/Lua output file should be within specified defold project root (" + defoldRoot + "), but is " + outFile + ". Check -lua argument in your build hxml file.", Context.currentPos());
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
