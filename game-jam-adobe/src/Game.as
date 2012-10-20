package
{	
	import starling.events.Event;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import game.debug.ScreenPrint;
	import game.entities.Bullet;
	import game.entities.Enemy;
	import game.entities.Hero;
	import game.utils.AssetLibrary;
	import game.utils.FrameTime;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Game extends Sprite
	{
		private var _gameLayer:Sprite = new Sprite();
		private var _uiLayer:Sprite = new Sprite();
		private var _debugLayer:Sprite = new Sprite();

		public function Game()
		{
			addChild(_gameLayer);
			addChild(_uiLayer);
			addChild(_debugLayer);

			// init game layer.
			var hero:Hero = new Hero();
			_gameLayer.addChild(hero.sprite);

			var enemy:Enemy = new Enemy();
			enemy.sprite.y = 50;
			_gameLayer.addChild(enemy.sprite);

			var bullet:Bullet = new Bullet();
			bullet.sprite.x = 50;
			bullet.sprite.y = 50;
			_gameLayer.addChild(bullet.sprite);

			// init ui layer.
			var textField:TextField = new TextField(300, 100, "Score: 0");
			_uiLayer.addChild(textField);

			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}

		private function handleAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			this.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		private function handleRemovedFromStage(evt:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			this.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		private function handleEnterFrame(evt:Event):void
		{
			// update the game
			updateGame();
		}

		private function updateGame():void
		{
			ScreenPrint.show("ms: " + FrameTime.dt);
		}

	}
}