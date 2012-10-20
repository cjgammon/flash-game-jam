/**
*	
*/
package game.states.mainStates
{	
	import Game;
	import game.data.GameData;
	import game.data.PlayerData;
	import game.states.IState;
	import game.states.mainStates.*;
	import game.ui.MainMenu;
	import starling.events.Event;
	

	/**
	*	state player is in when they're at the main menu
	*/
	public class FrontEndState extends MainState implements IState 
	{
		override public function get name():String{ return "FrontEndState"; }

		private var _mainMenu:MainMenu;

		/**
		*	@constructor
		*/
		public function FrontEndState(game:Game):void
		{
			super(game);
		}
				
		override public function enter():void
		{
			super.enter();
			
			// start main menu!
			_mainMenu = new MainMenu();
			_game.uiLayer.addChild(_mainMenu);
			_mainMenu.addEventListener(MainMenu.START_GAME, handleStartGame)
		}

		override public function exit():void
		{
			super.exit();
			
			// clean up main menu
			if (_mainMenu)
			{
				_mainMenu.removeEventListener(MainMenu.START_GAME, handleStartGame);
				if (_mainMenu.parent) _mainMenu.parent.removeChild(_mainMenu);
				_mainMenu = null;
			}
		}

		private function handleStartGame(evt:Event):void
		{
			// set up the game data for the current game mode!
			var gameData:GameData = _game.gameData;
			gameData.setPlayerType(0, PlayerData.TYPE_HUMAN_LOCAL);
			gameData.setPlayerType(1, PlayerData.TYPE_INVALID);
			gameData.setPlayerType(2, PlayerData.TYPE_INVALID);
			gameData.setPlayerType(3, PlayerData.TYPE_INVALID);

			// gtfo
			_game.changeState(_game.gameplayState);
		}
	}
}