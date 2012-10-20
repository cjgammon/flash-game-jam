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
	import game.utils.InputManager;
	import starling.text.TextField;

	/**
	*	this is the state the app is in while the player is mid-game
	*/
	public class GameplayState extends MainState implements IState 
	{
		override public function get name():String{ return "GameState"; }


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

			// init ui layer.
			var textField:TextField = new TextField(300, 100, "Score: 0");
			_game.uiLayer.addChild(textField);
		}

		override public function exit():void
		{
			super.exit();
			// todo :: clean up game
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