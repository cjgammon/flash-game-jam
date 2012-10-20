package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.data.GlobalData;
	import game.debug.Stats;
	import game.debug.ScreenPrint;
	import game.utils.DebugDraw;
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
			_starling.stage.stageWidth = GlobalData.SCENE_WIDTH;
			_starling.stage.stageHeight = GlobalData.SCENE_HEIGHT;
			_starling.start();

			if (GlobalData.DEBUG)
			{
				_debugLayer = new Sprite();
				addChild(_debugLayer);

				_debugLayer.addChild(DebugDraw.canvas);

				//_stats = new Stats();
				//_debugLayer.addChild(_stats);

				ScreenPrint.init(_debugLayer);
			}
						
			InputManager.init(this.stage, InputManager.MANAGE_KEYBOARD, true);// 2nd param ==  manage mouse t/f
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
			if (GlobalData.DEBUG) ScreenPrint.update();

			//
			InputManager.update();
		}
	}
}