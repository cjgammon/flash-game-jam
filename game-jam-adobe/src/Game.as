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
	import game.utils.InputManager;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Game extends Sprite
	{
		private var _gameLayer:Sprite = new Sprite();
		private var _uiLayer:Sprite = new Sprite();
		private var _debugLayer:Sprite = new Sprite();

		/**
		* should try to keep things more organized, but let's hit the gas for now.
		*/
		private var _hero:Hero;

		public function Game()
		{
			addChild(_gameLayer);
			addChild(_uiLayer);
			addChild(_debugLayer);

			// init game layer.
			_hero = new Hero();
			_gameLayer.addChild(_hero.sprite);

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
			// check if they're running
			if (InputManager.keyPressed(InputManager.INPUT_RUN))
			{
				_hero.isRunning = true;
			}
			else if (InputManager.keyReleased(InputManager.INPUT_RUN))
			{
				_hero.isRunning = false;
			}

			if (InputManager.isKeyDown(InputManager.INPUT_MOVE_LEFT))
			{
				_hero.sprite.x -= _hero.movementSpeed;
			}
			else if (InputManager.isKeyDown(InputManager.INPUT_MOVE_RIGHT))
			{
				_hero.sprite.x += _hero.movementSpeed;
			}
			if (InputManager.isKeyDown(InputManager.INPUT_MOVE_UP))
			{
				_hero.sprite.y -= _hero.movementSpeed;
			}
			else if (InputManager.isKeyDown(InputManager.INPUT_MOVE_DOWN))
			{
				_hero.sprite.y += _hero.movementSpeed;
			}
			updateGame();
		}

		private function updateGame():void
		{
			ScreenPrint.show("ms: " + FrameTime.dt);
		}

	}
}