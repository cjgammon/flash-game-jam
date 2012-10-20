/**
*	
*/
package game.states.mainStates
{	
	import Game.*;
	
	import game.data.GameData;
	import game.data.GlobalData;
	import game.data.Player;
	import game.entities.*;
	import game.entities.Bullet;
	import game.entities.controllers.*;
	import game.states.IState;
	import game.states.mainStates.*;
	import game.ui.Hud;
	import game.utils.AssetLibrary;
	import game.utils.InputManager;
	
	import starling.core.Starling;
	import starling.extensions.ParticleDesignerPS;
	import starling.text.TextField;
	import starling.textures.Texture;

	/**
	*	this is the state the app is in while the player is mid-game
	*/
	public class GameplayState extends MainState implements IState 
	{
		public static var instance:GameplayState;

		override public function get name():String{ return "GameState"; }

		private var _hud:Hud;

		private var _activePlayerTotal:int = 0;
		private var _activePlayers:Vector.<Player> = new Vector.<Player>();
		private var _enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>();

		/**
		*	@constructor
		*/
		public function GameplayState(game:Game):void
		{
			// ghetto singleton setup, just get it going.
			if (!instance) instance = this;

			super(game);
		}
				
		override public function enter():void
		{
			super.enter();

			// build up a list of active players so we know who is playing the game.
			var heroTotal:int = _game.gameData.players.length;
			for (var heroIndex:int = 0; heroIndex < heroTotal; heroIndex++)
			{
				var playerData:Player = _game.gameData.players[heroIndex];
				if (playerData.playerType != Player.TYPE_INVALID)
				{
					_activePlayers.push(playerData);
				}
			}

			//========================================================
			// set up all the active players' avatars
			//========================================================
			_activePlayerTotal = _activePlayers.length;
			for (var activePlayerIndex:int = 0; activePlayerIndex < _activePlayerTotal; activePlayerIndex++)
			{
				var activePlayer:Player = _activePlayers[activePlayerIndex];

				// TODO :: set up hero class based on character selection
				//if (activePlayer.characterType == ANGRY_GORILLA) activePlayer.avatar = new Gorilla();
				activePlayer.avatar = new Hero() as LivingEntity;
				activePlayer.avatar.controller = EntityController.getControllerType(LocalPlayerController);
				activePlayer.avatar.x = GlobalData.HALF_SCENE_WIDTH;
				activePlayer.avatar.y = GlobalData.HALF_SCENE_HEIGHT;
			}
			
			//========================================================
			// enemy test.  
			// TODO :: refactor this so there's an add enemy function somewhere that's easy to access.
			//========================================================
			for (var enemyIndex:int = 0; enemyIndex < 10; enemyIndex++)
			{
				var enemy:Enemy = new Enemy();

				enemy.target = _activePlayers[0].avatar;
				enemy.controller = EntityController.getControllerType(AIControllerBasic);
				enemy.x = enemyIndex % 2 == 0 ? GlobalData.SCENE_WIDTH : 0;  //left side or right side
				enemy.y = Math.random() * GlobalData.HALF_SCENE_HEIGHT;
				_game.gameLayer.addChild(enemy.sprite);
				_enemies.push(enemy);
			}

			//========================================================
			// add the heroes to the stage, on top of the enemies for now.
			//========================================================
			for (activePlayerIndex = 0; activePlayerIndex < _activePlayerTotal; activePlayerIndex++)
			{
				_game.gameLayer.addChild(_activePlayers[activePlayerIndex].avatar.sprite);
			}

			//========================================================
			// add some powerups
			//========================================================
			for (var powerupIndex:int = 0; powerupIndex < 2; powerupIndex++)
			{
				var powerup:Powerup = new Powerup();
				powerup.x = int(Math.random() * GlobalData.SCENE_WIDTH);
				powerup.y = int(Math.random() * GlobalData.SCENE_HEIGHT);
				_game.gameLayer.addChild(powerup.sprite);
			}

			/*
			// bullet test.
			var bullet:Bullet = new Bullet();
			bullet.sprite.x = 50;
			bullet.sprite.y = 50;
			_game.gameLayer.addChild(bullet.sprite);
			*/
			
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
				_hud = null;
			}
			
			// clean up hero
			for (var activePlayerIndex:int = 0; activePlayerIndex < _activePlayerTotal; activePlayerIndex++)
			while(_activePlayers.length > 0)
			{
				var player:Player = _activePlayers.pop();
				if (player && player.avatar.sprite.parent)
				{
					player.avatar.sprite.removeChild(player.avatar.sprite);
				}	
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
			bulletsUpdate();
		}
		
		public function spawnBullet(x:Number, y:Number):void
		{
			var bullet:Bullet = new Bullet();
			bullet.sprite.x = x;
			bullet.sprite.y = y;
			_bullets.push(bullet);
			_game.gameLayer.addChild(bullet.sprite);
		}
		
		private function bulletsUpdate():void
		{
			var bulletTotal:int = _bullets.length;
			for (var bulletIndex:int = 0; bulletIndex < bulletTotal; bulletIndex++)
			{
				var bullet:Bullet = _bullets[bulletIndex];
				bullet.update();
			}
		}

		private function heroTurn():void
		{
			for (var activePlayerIndex:int = 0; activePlayerIndex < _activePlayerTotal; activePlayerIndex++)
			{
				var activePlayer:Player = _activePlayers[activePlayerIndex];
				activePlayer.avatar.takeTurn();
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