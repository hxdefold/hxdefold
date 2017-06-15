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
    static function get_cpu_usage():Float;

    /**
        Get the amount of memory used (resident/working set) by the application in bytes, as reported by the OS. (Not available on HTML5.)

        The values are gathered from internal OS functions which correspond to the following;

        OS                          | Value
        ----------------------------|------------------
        iOS, OSX, Android and Linux | Resident memory
        Windows                     | Working set
        HTML5                       | Not available

        @return bytes used by the application
    **/
    static function get_memory_usage():Int;
}
