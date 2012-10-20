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
	}
}