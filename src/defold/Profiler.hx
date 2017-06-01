package defold;

/**
    Functions for getting profiling data in runtime.
    More detailed profiling and debugging information can be found under the <a href="http://www.defold.com/manuals/debugging/">Debugging</a> section in the manuals.
**/
@:native("_G.profiler")
extern class Profiler {
    /**
        Get the percent of CPU usage by the application, as reported by the OS. (Not available on HTML5.)

        For some platforms (Android, Linux and Windows), this information is only available
        by default in the debug version of the engine. It can be enabled in release version as well
        by checking `track_cpu` under `profiler` in the `game.project` file.
        (This means that the engine will sample the CPU usage in intervalls during execution even in release mode.)

        @return number of CPU used by the application
    **/
    static function cpu_usage():Float;

    /**
        Get the amount of memory used (resident/working set) by the application in bytes, as reported by the OS. (Not available on HTML5.)

        @return bytes used by the application
    **/
    static function memory_usage():Int;
}
