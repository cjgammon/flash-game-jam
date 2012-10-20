/**
*	
*/
package game.ui
{	
	import game.data.GlobalData;
	import game.data.Player;
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
		private var _healthIndicators:Array;
		private var _gameOver:Sprite;


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

			var activeHeroes:Vector.<Player> = _gameState.activePlayers;
			var activeHeroTotal:int = activeHeroes.length;
			_healthIndicators = new Array();
			for (var playerIndex:int = 0; playerIndex < activeHeroTotal; playerIndex++)
			{
				var player:Player = _gameState.activePlayers[playerIndex];

				var tf:TextField = new TextField(100, 18, "Health: " + player.avatar.health);
				tf.x = GlobalData.SCENE_WIDTH - 100;
				tf.y = 0;
				addChild(tf);
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

		public function setPlayerHealth(playerIndex:int, healthValue:int):void
		{
			var health:TextField = _healthIndicators[playerIndex];
			if (health) health.text = "Health: " + healthValue;
		}

		public function gameOver():void
		{
			//addChild(_gameOver);
		}
	}
}