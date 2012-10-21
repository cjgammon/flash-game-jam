package
{	
	import starling.events.Event;
	import game.data.GameData;
	import game.entities.Powerup;
	import game.states.StateMachine;
	import game.states.IState;
	import game.states.mainStates.*;
	import game.ui.Hud;
	import game.utils.FrameTime;
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		/**
		* GameData holds onto all our necessary shit, like player scores/stats, game mode, etc.
		* it's meant to persist from state-to-state
		*/
		public var gameData:GameData = new GameData();

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
		public function changeState(newState:IState):void{ _stateMachine.changeState(newState); }

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

			// init the powerup textures
			Powerup.initGraphicRefs();

			// init game states
			_frontEndState = new FrontEndState(this);
			_gameplayState = new GameplayState(this);
			_gameOverState = new GameOverState(this);
			_stateMachine.changeState(_frontEndState);

			this.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		private function handleEnterFrame(evt:Event):void
		{
			_stateMachine.update(FrameTime.dt)
		}
	}
}