package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.debug.Stats;
	import game.debug.ScreenPrint;
	import game.utils.FrameTime;
	import game.utils.InputManager;
	import starling.core.Starling;

	

	[SWF(width="900", height="800", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		private var _starling:Starling;
		public function get starling():Starling { return _starling; }

		private var _gameClass:Class = Game;
		public function get gameClass():Class { return _gameClass; }

		private var _debugLayer:Sprite;
		private var _stats:Stats;

		public function Main()
		{
			_starling = new Starling(_gameClass, stage);
			_starling.stage.stageWidth = 450;//200;
			_starling.stage.stageHeight = 400;//150;  //set to half of screen size
			_starling.start();

			_debugLayer = new Sprite();
			addChild(_debugLayer);

			_stats = new Stats();
			_debugLayer.addChild(_stats);

			// set up some system utility stuff that should check keys, make debugging easier, etc
			ScreenPrint.init(_debugLayer);
			InputManager.init(this.stage, InputManager.MANAGE_KEYBOARD, false);// 2nd param false == don't manage mouse
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

			//
			InputManager.update();
		}
	}
}