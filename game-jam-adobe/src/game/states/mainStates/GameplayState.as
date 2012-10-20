/**
*	
*/
package game.states.mainStates
{	
	import Game;
	import game.data.GameData;
	import game.data.Player;
	import game.entities.*;
	import game.entities.controllers.*;
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

		private var _activePlayerTotal:int = 0;
		private var _activePlayers:Vector.<Player> = new Vector.<Player>();
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
				//if (activePlayer.characterType == ANGRY_GORILLA) ctivePlayer.avatar = new Gorilla();
				activePlayer.avatar = new Hero() as LivingEntity;
				activePlayer.avatar.controller = EntityController.getControllerType(LocalPlayerController);
				activePlayer.avatar.sprite.x = 100;
				activePlayer.avatar.sprite.y = 100;

				// big money, big prizes.
				var money:ParticleDesignerPS = new ParticleDesignerPS(XML(new AssetLibrary.MoneyParticleXML()), Texture.fromBitmap(new AssetLibrary.MoneyParticleTexture()));
				money.x = activePlayer.avatar.sprite.x;
				money.y = 100;
				money.start();			
				Starling.juggler.add(money);
				_game.gameLayer.addChild(money);
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
				enemy.sprite.x = enemyIndex % 2 == 0 ? 200 : 0;  //left side or right side
				enemy.sprite.y = Math.random() * 200;
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