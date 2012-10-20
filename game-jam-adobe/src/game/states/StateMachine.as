package game.states
{
	import game.debug.ScreenPrint;
	import game.states.IState;
	
	public class StateMachine 
	{
		private var _currentState:IState;
		public function get currentState():IState{ return _currentState; }
		
		/**
		* @constructor
		*/
		public function StateMachine():void
		{
			_currentState = null;
		}
		
		public function update(dt:Number):void
		{
			if (_currentState)
			{
				ScreenPrint.show("STATE: " + _currentState.name);
				_currentState.update(dt);
			}
		}
		
		public function changeState(state:IState):void
		{
			if (_currentState)
			{
				_currentState.exit();
			}
			_currentState = state;
			_currentState.enter();
		}		
	}
}