import haxe.crypto.Crc32;
import haxe.zip.Entry;
import haxe.zip.Writer;
import haxe.zip.Tools;
import sys.io.File;
import sys.FileSystem;

class Release {
    static var outPath = "release.zip";
    static var files = ["haxelib.json", "src", "extraParams.hxml", "LICENSE.md", "README.md"];

    static function makeZip() {
        var entries = new List<Entry>();

        function add(path:String, target:String) {
            if (!FileSystem.exists(path))
                throw 'Invalid path: $path';

            if (FileSystem.isDirectory(path)) {
                for (item in FileSystem.readDirectory(path))
                    add(path + "/" + item, target + "/" + item);
            } else {
                trace("Adding " + target);
                var bytes = File.getBytes(path);
                var entry:Entry = {
                    fileName: target,
                    fileSize: bytes.length,
                    fileTime: FileSystem.stat(path).mtime,
                    compressed: false,
                    dataSize: 0,
                    data: bytes,
                    crc32: Crc32.make(bytes),
                }
                Tools.compress(entry, 9);
                entries.add(entry);
            }
        }

        for (file in files)
            add(file, file);

        trace("Saving to " + outPath);
        var out = File.write(outPath, true);
        var writer = new Writer(out);
        writer.write(entries);
        out.close();
    }

    static function submitZip() {
        trace("Submitting " + outPath);
        Sys.command("haxelib", ["submit", outPath]);
    }

    static function main() {
        makeZip();
        submitZip();
    }
}
