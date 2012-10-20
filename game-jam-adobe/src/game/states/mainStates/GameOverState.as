/**
*	
*/
package game.states.mainStates
{	
	import game.states.IState;
	import game.states.mainStates.*;
	import Game;

	/**
	*	the state the player is in when they finished playing and they're at the game over screen
	*/
	public class GameOverState extends MainState implements IState 
	{
		override public function get name():String{ return "GameOverState"; }

		/**
		*	@constructor
		*/
		public function GameOverState(game:Game):void
		{
			super(game);
		}
				
		override public function enter():void
		{
			super.enter();
			// todo :: init enter screen.
		}

		override public function exit():void
		{
			super.exit();
			// todo :: clean up game over screen
		}
	}
}