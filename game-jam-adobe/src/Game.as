package
{	
	import starling.events.Event;
	import game.states.StateMachine;
	import game.states.mainStates.*;
	import game.utils.FrameTime;
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		//========================================================
		// display layers to render content to.
		//========================================================
		/**
		* game layer is where we render our gameplay.
		*/
		private var _gameLayer:Sprite = new Sprite();
		public function get gameLayer():Sprite { return _gameLayer; }

		/**
		* ui layer is for the hud / menu system
		*/
		private var _uiLayer:Sprite = new Sprite();
		public function get uiLayer():Sprite { return _uiLayer; }

		/**
		* the debug layer is for screenprints/fps counter, etc
		*/
		private var _debugLayer:Sprite = new Sprite();
		public function get debugLayer():Sprite { return _debugLayer; }


		//========================================================
		// game states for managing flow from frontend -> game -> game over, etc
		//========================================================
		private var _stateMachine:StateMachine = new StateMachine();

		/**
		* the front end state is the main menu stuff
		*/
		private var _frontEndState:FrontEndState;
		public function get frontEndState():FrontEndState { return _frontEndState; }

		/**
		* the front end state is the main menu stuff
		*/
		private var _gameplayState:GameplayState;
		public function get gameplayState():GameplayState { return _gameplayState; }

		/**
		* the front end state is the main menu stuff
		*/
		private var _gameOverState:GameOverState;
		public function get gameOverState():GameOverState { return _gameOverState; }


		/**
		* @constructor
		*/
		public function Game()
		{
			addChild(_gameLayer);
			addChild(_uiLayer);
			addChild(_debugLayer);
			
			// init game states
			_frontEndState = new FrontEndState(this);
			_gameplayState = new GameplayState(this);
			_gameOverState = new GameOverState(this);
			_stateMachine.changeState(_gameplayState);

			this.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		private function handleEnterFrame(evt:Event):void
		{
			_stateMachine.update(FrameTime.dt)
		}
	}
}