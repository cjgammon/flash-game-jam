/**
*	
*/
package game.states.mainStates
{	
	import Game;
	import game.states.IState;

	/**
	*	base class for states that the main application uses, in case we want a lot of dupe functionality for switching states, i dunno.
	*/
	public class MainState implements IState 
	{
		public function get name():String{ return "MainState"; }

		protected var _game:Game;

		/**
		*	@constructor
		*/
		public function MainState(game:Game):void
		{
			_game = game;
		}
				
		public function enter():void
		{
			
		}

		public function exit():void
		{
			
		}

		public function update(dt:Number):void
		{
			
		}
	}
}