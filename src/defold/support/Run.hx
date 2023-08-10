package defold.support;

// this is the init script executed by `haxelib run hxdefold`
#if (interp || eval)
import haxe.io.Path;

class Run {
	static function main() {
		var args = std.Sys.args();
		var cwd = if (std.Sys.getEnv("HAXELIB_RUN") != null) args.pop() else std.Sys.getCwd();
		if (args.length != 1) {
			std.Sys.println("Usage: haxelib run hxdefold init");
			std.Sys.exit(0);
		}

		switch args[0] {
			case "init":
				init(cwd);
		}
	}

	static var hxml = [
		"# where to look for Haxe sources",
		"-cp src",
		"# where to generate Lua output",
		"-lua main.lua",
		"# enable hxdefold Haxe library",
		"-lib hxdefold",
		"# enable full dead code elimination",
		"-dce full",
		"# enable static optimizations",
		"-D analyzer-optimize",
		"# recursively include all Haxe sources in the source diretory",
		'--macro include("", true, null, ["src"])',
		"",
		"# override to specify another Defold project root directory",
		"#-D hxdefold-projectroot=.",
		"# override to specify another output directory for generated script files (relative to the project root)",
		"#-D hxdefold-scriptdir=scripts",
	].join("\n");

	static var sample =
"// sample script component code

// component class that defines the callback methods
// after compiling Haxe, the `Hello.script` will appear in the Defold project that can be attached to game objects
class Hello extends defold.support.Script {

	// variables with the @property tag will generate editor properties
	@property var power: Int = 9000;

	// variables without the tag will only be accessible from within the script
	var world: Bool = false;

	// the `init` callback method
	override function init() {
		trace('Haxe is over ${power}!'); // will be printed to the debug console
	}
}
";

	static function init(dir:String) {
		var hxmlPath = Path.join([dir, "build.hxml"]);
		sys.io.File.saveContent(hxmlPath, hxml);

		var srcPath = Path.join([dir, "src"]);
		sys.FileSystem.createDirectory(srcPath);

		var samplePath = Path.join([srcPath, "Hello.hx"]);
		sys.io.File.saveContent(samplePath, sample);
	}
}
#end