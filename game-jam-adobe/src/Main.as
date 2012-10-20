package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.debug.Stats;
	import game.debug.ScreenPrint;
	import game.utils.FrameTime;
	import starling.core.Starling;

	

	[SWF(width="400", height="300", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		private var _starling:Starling;

		private var _debugLayer:Sprite;
		private var _stats:Stats;

		public function Main()
		{
			_starling = new Starling(Game, stage);
			_starling.start();

			_debugLayer = new Sprite();
			addChild(_debugLayer);

			//_stats = new Stats();
			//_debugLayer.addChild(_stats);

			ScreenPrint.init(_debugLayer);

			this.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		/**
		* simple loop maintains some system type stuff that the game probably doesn't need to worry about.
		*/
		private function handleEnterFrame(evt:Event):void
		{
			// get how much time has passed
			FrameTime.update();

			// update various utils
			ScreenPrint.update();
		}
	}
}