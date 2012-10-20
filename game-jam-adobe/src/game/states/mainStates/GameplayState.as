/**
*	
*/
package game.states.mainStates
{	
	import Game;
	import game.entities.Bullet;
	import game.entities.Enemy;
	import game.entities.Hero;
	import game.states.IState;
	import game.states.mainStates.*;
	import game.ui.Hud;
	import game.utils.InputManager;
	import game.utils.AssetLibrary;

	import starling.core.Starling;
	import starling.text.TextField;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;

	/**
	*	this is the state the app is in while the player is mid-game
	*/
	public class GameplayState extends MainState implements IState 
	{
		override public function get name():String{ return "GameState"; }

		private var _hud:Hud;

		private var _hero:Hero;
		private var _enemies:Vector.<Enemy> = new Vector.<Enemy>();

		/**
		*	@constructor
		*/
		public function GameplayState(game:Game):void
		{
			super(game);
		}
				
		override public function enter():void
		{
			super.enter();

			// init game.
			_hero = new Hero();
			_hero.sprite.x = 100;
			_game.gameLayer.addChild(_hero.sprite);

			// enemy test.  
			// TODO :: refactor this so there's an add enemy function somewhere that's easy to access.
			for (var enemyIndex:int = 0; enemyIndex < 500; enemyIndex++)
			{
				var enemy:Enemy = new Enemy();
				enemy.target = _hero;
				enemy.sprite.x = enemyIndex % 2 == 0 ? 200 : 0;  //left side or right side
				enemy.sprite.y = Math.random() * 200;
				_game.gameLayer.addChild(enemy.sprite);
				_enemies.push(enemy);
			}

			// bullet test.
			var bullet:Bullet = new Bullet();
			bullet.sprite.x = 50;
			bullet.sprite.y = 50;
			_game.gameLayer.addChild(bullet.sprite);

			var money:ParticleDesignerPS = new ParticleDesignerPS(XML(new AssetLibrary.MoneyParticleXML()), Texture.fromBitmap(new AssetLibrary.MoneyParticleTexture()));
			money.x = _hero.sprite.x;
			money.y = 100;
			money.start();			
			Starling.juggler.add(money);
			_game.gameLayer.addChild(money);
			
			// init ui layer.
			_hud = new Hud();
			_game.uiLayer.addChild(_hud);
		}

		override public function exit():void
		{
			super.exit();

			// clean up ui
			if (_hud && _hud.parent)
			{
				_hud.parent.removeChild(_hud);
			}
			
			// clean up hero
			if (_hero && _hero.sprite.parent)
			{
				_hero.sprite.removeChild(_hero.sprite);
			}

			// cleanup enemies
			while(_enemies.length > 0)
			{
				var enemy:Enemy = _enemies.pop();
				if (enemy && enemy.sprite.parent)
				{
					enemy.sprite.removeChild(enemy.sprite);
				}
			}
		}

		override public function update(dt:Number):void
		{
			heroTurn();
			enemyTurn();
		}

		private function heroTurn():void
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
		}

		private function enemyTurn():void
		{
			var enemyTotal:int = _enemies.length;
			for (var enemyIndex:int = 0; enemyIndex < enemyTotal; enemyIndex++)
			{
				var enemy:Enemy = _enemies[enemyIndex];
				enemy.takeTurn();
			}
		}
	}
}