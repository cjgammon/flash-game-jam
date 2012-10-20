/**
*	
*/
package game.states.mainStates
{	
	import game.states.IState;
	import game.states.mainStates.*;
	import Game;

	/**
	*	state player is in when they're at the main menu
	*/
	public class FrontEndState extends MainState implements IState 
	{
		override public function get name():String{ return "FrontEndState"; }

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
			// todo :: set up front end
		}

		override public function exit():void
		{
			super.exit();
			// todo :: kill front end.
		}
	}
}