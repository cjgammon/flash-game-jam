/**
*	
*/
package game.ui
{	
	import com.greensock.TweenMax;
	import game.data.GlobalData;
	import game.data.Player;
	import game.entities.Powerup;
	import game.states.mainStates.GameplayState;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	*	
	*/
	public class Hud extends Sprite
	{
		private var _gameState:GameplayState;
		private var _score:TextField;
		private var _kills:TextField;
		private var _healthIndicators:Array;
		private var _gameOver:Sprite;

		private var _popupLayer:Sprite;
		private var _currentPopup:Sprite;


		/**
		*	@constructor
		*/
		public function Hud():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}

		private function handleAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);

			_gameState = GameplayState.instance;

			// set up our stuff
			_score = new TextField(100, 20, "Score: 0");
			_score.x = 0;
			_score.y = 0;
			addChild(_score);

			_kills = new TextField(100, 20, "Kills: 0");
			_kills.x = 0;
			_kills.y = _score.y + _score.height;
			addChild(_kills);
			
			var activeHeroes:Vector.<Player> = _gameState.activePlayers;
			var activeHeroTotal:int = activeHeroes.length;
			_healthIndicators = new Array();
			for (var playerIndex:int = 0; playerIndex < activeHeroTotal; playerIndex++)
			{
				var player:Player = _gameState.activePlayers[playerIndex];

				var tf:TextField = new TextField(100, 18, "Health: " + player.avatar.health);
				tf.x = GlobalData.SCENE_WIDTH - 100;
				tf.y = 0;
				//addChild(tf);
				_healthIndicators[player.playerIndex] = tf
			}
			/*
			_gameOver = new Sprite();
			var gameOverText:TextField = new TextField(300, 40, "GAME OVER!");

			var scoreText:TextField = new TextField(200, 20, "Final Score:");
			scoreText.y = gameOverText.y + gameOverText.height;

			var continueText:TextField = new TextField(300, 40, "Click to Retry");
			continueText.y = scoreText.y + scoreText.height + 20;
			*/

			// 
			
		}

		private function handleRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);	

			if (_score.parent) _score.parent.removeChild(_score);
		}

		public function setScore(value:int):void
		{
			_score.text = "Score: " + value;
		}

		/**
		* 
		*/
		public function setKills(playerIndex:int, kills:int):void
		{
			_kills.text = "Kills: " + kills;
		}

		public function setPlayerHealth(playerIndex:int, healthValue:int):void
		{
			var health:TextField = _healthIndicators[playerIndex];
			if (health) health.text = "Health: " + healthValue;
		}

		public function gameOver():void
		{
			//addChild(_gameOver);
		}

		public function powerupAcquired(powerup:Powerup):void
		{
			if (_popupLayer && _popupLayer.parent)
			{
				TweenMax.killTweensOf(_popupLayer);
				_popupLayer.parent.removeChild(_popupLayer);
				_popupLayer = null;
				_currentPopup = null
			}

			_popupLayer = new Sprite();
			_popupLayer.scaleX = _popupLayer.scaleY = 0.5;
			_popupLayer.x = GlobalData.HALF_SCENE_WIDTH - (171*0.5);
			_popupLayer.y = -102;
			addChild(_popupLayer);

			var t:Object = Powerup.typeGraphics[powerup.id];
			if (t && t.popup)
			{
				_currentPopup = t.popup
				_currentPopup.x = t.popup.width*-0.5;
				_currentPopup.y = t.popup.height*-0.5;
				_popupLayer.addChild(t.popup);
				TweenMax.to(_popupLayer, 0.2, {y:0, onComplete:powerupOpened});
			}
		}

		private function powerupOpened():void
		{
			if (_currentPopup) TweenMax.to(_currentPopup, 0.2, {delay: 3.0, y:-102, onComplete:powerupClosed});
		}

		private function powerupClosed():void
		{
			if (_popupLayer && _popupLayer.parent)
			{
				_popupLayer.parent.removeChild(_popupLayer);
				_popupLayer = null;
				_currentPopup = null
			}
		}

	}
}