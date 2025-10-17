package defold;

/**
	Functions for getting profiling data in runtime.
	More detailed <a href="https://www.defold.com/manuals/profiling/">profiling</a> and <a href="http://www.defold.com/manuals/debugging/">debugging</a> information available in the manuals.</p>
**/
@:native("_G.profiler")
extern final class Profiler {
	/**
		Creates and shows or hides and destroys the on-sceen profiler ui

		The profiler is a real-time tool that shows the numbers of milliseconds spent
		in each scope per frame as well as counters. The profiler is very useful for
		tracking down performance and resource problems.

		@param enabled true to enable, false to disable
	**/
	@:native('enable_ui')
	static function enableUi(enabled:Bool):Void;

	/**
		Get the percent of CPU usage by the application, as reported by the OS.

		This function is not available on HTML5.

		For some platforms (Android, Linux and Windows), this information is only available
		by default in the debug version of the engine. It can be enabled in release version as well
		by checking `track_cpu` under `profiler` in the `game.project` file.
		(This means that the engine will sample the CPU usage in intervalls during execution even in release mode.)

		@return number of CPU used by the application
	**/
	@:native('get_cpu_usage')
	static function getCpuUsage():Float;

	/**
		Get the amount of memory used (resident/working set) by the application in bytes, as reported by the OS.

		This function is not available on HTML5.

		The values are gathered from internal OS functions which correspond to the following;

		OS                          | Value
		----------------------------|------------------
		iOS, OSX, Android and Linux | Resident memory
		Windows                     | Working set
		HTML5                       | Not available

		@return bytes used by the application
	**/
	@:native('get_memory_usage')
	static function getMemoryUsage():Int;

	/**
		Get the number of recorded frames in the on-screen profiler ui recording buffer

		@return the number of recorded frames, zero if on-screen profiler is disabled
	**/
	@:native('recorded_frame_count')
	static function recordedFrameCount():Int;

	/**
		Set the on-screen profile mode - run, pause, record or show peak frame

		@param mode the mode to set the ui profiler in

		To stop recording, switch to a different mode such as `MODE_PAUSE` or `MODE_RUN`.
		You can also use the `view_recorded_frame` function to display a recorded frame. Doing so stops the recording as well.

		Every time you switch to recording mode the recording buffer is cleared.
		The recording buffer is also cleared when setting the `MODE_SHOW_PEAK_FRAME` mode.
	**/
	@:native('set_ui_mode')
	static function setUiMode(mode:ProfilerMode):Void;

	/**
		Set the on-screen profile view mode - minimized or expanded

		@param mode the view mode to set the ui profiler in
	**/
	@:native('set_ui_view_mode')
	static function setUiViewMode(mode:ProfilerViewMode):Void;

	/**
		Shows or hides the time the engine waits for vsync in the on-screen profiler

		Each frame the engine waits for vsync and depending on your vsync settings and how much time
		your game logic takes this time can dwarf the time in the game logic making it hard to
		see details in the on-screen profiler graph and lists.

		Also, by hiding this the FPS times in the header show the time spent each time excuding the
		time spent waiting for vsync. This shows you how long time your game is spending actively
		working each frame.

		This setting also effects the display of recorded frames but does not affect the actual
		recorded frames so it is possible to toggle this on and off when viewing recorded frames.

		By default the vsync wait times is displayed in the profiler.

		@param visible true to include it in the display, false to hide it.
	**/
	@:native('set_ui_vsync_wait_visible')
	static function setUiVsyncWaitVisible(visible:Bool):Void;

	/**
		Displays a previously recorded frame in the on-screen profiler ui.

		Pauses and displays a frame from the recording buffer in the on-screen profiler ui

		The frame to show can either be an absolute frame or a relative frame to the current frame.
	**/
	@:native('view_recorded_frame')
	static function viewRecordedFrame(frame_index:ProfilerViewRecordedFrame):Void;

	/**
		Dump the current frame profiling data to the output.

		Useful for capturing a snapshot of timing/scopes for the frame.
	**/
	@:native('dump_frame')
	static function dumpFrame():Void;
}

/**
	Data for `Profiler.view_recorded_frame`.
**/
typedef ProfilerViewRecordedFrame = {
	/**
		The offset from the currently displayed frame (this is truncated between zero and the number of recorded frames)
	**/
	var distance:Int;

	/**
		The frame index in the recording buffer (1 is first recorded frame)
	**/
	var frame:Int;
}

/**
	Possible values for `Profiler.set_ui_mode`.
**/
@:native("_G.profiler")
extern enum abstract ProfilerMode({}) {
	/**
		Pauses on the currently displayed frame
	**/
	@:native('MODE_PAUSE')
	var Pause;

	/**
		Records all incoming frames to the recording buffer
	**/
	@:native('MODE_RECORD')
	var Record;

	/**
		This is default mode that continously shows the last frame
	**/
	@:native('MODE_RUN')
	var run;

	/**
		Pauses on the currently displayed frame but shows a new frame if that frame is slower
	**/
	@:native('MODE_SHOW_PEAK_FRAME')
	var ShowPeakFrame;
}

/**
	Possible values for `Profiler.set_ui_view_mode`.
**/
@:native("_G.profiler")
extern enum abstract ProfilerViewMode({}) {
	/**
		The default mode which displays all the ui profiler details
	**/
	@:native('VIEW_MODE_FULL')
	var ModeFull;

	/**
		Minimized mode which only shows the top header (fps counters and ui profiler mode)
	**/
	@:native('VIEW_MODE_MINIMIZED')
	var Minimized;
}
