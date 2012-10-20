/**
*	
*/
package game.utils
{	
	import flash.utils.getTimer;

	/**
	*	simple class for managing dt.  i'm sick of doing it every time for new projects
	*/
	public class FrameTime 
	{
		public static const FPS:int = 60;// TODO :: hardcoded fps
		public static const FPS_TIME_MS:int = (1/FPS) * 1000;

		public static function get timeDiffInSeconds():Number{ return _timeDiffInSeconds; }
		public static function get dt():int{ return _dt; }
		private static var _dt:int = 0;
		private static var _timeDiffInSeconds:Number = 0;
		private static var _timeLastFrame:int = 0;

		private static var _frameRatePercent:Number = 0.0;
		public static function get frameRatePercent():Number{ return _frameRatePercent; }
		
		public static function update():void
		{
			var time:int = getTimer();
			_dt = time - _timeLastFrame;
			_timeDiffInSeconds = _dt * 0.001;
			_timeLastFrame = time;

			_frameRatePercent = _dt / FPS_TIME_MS
		}
	}
}