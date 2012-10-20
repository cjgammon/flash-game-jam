package game.utils
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import game.debug.ScreenPrint;

	/**
	* Manages which keys are held down.
	*/
	public class InputManager extends Object
	{
		
		//========================================================
		// config types
		//========================================================
		public static const MANAGE_KEYBOARD:Boolean = true;
		public static const DONT_MANAGE_KEYBOARD:Boolean = false;

		//============================================
		//	static 
		//============================================
		///// CONSTANTS
		/// SPECIAL KEYS
		public static const KEY_SPACE:int 			= 32;
		public static const KEY_RETURN:int 			= 13;
		public static const KEY_ESC:int 			= 27;
		public static const KEY_TILDE:int 			= 192;
		public static const KEY_CTRL:int 			= 17;
		public static const KEY_TAB:int 			= 9;
		public static const KEY_SHIFT:int 			= 16;
		public static const KEY_MINUS:int 			= 189;
		public static const KEY_PLUS:int 			= 187;

		// ARROW KEYS
		public static const KEY_LEFT:int 			= 37;
		public static const KEY_RIGHT:int 			= 39;
		public static const KEY_UP:int 				= 38;
		public static const KEY_DOWN:int 			= 40;

		// NUM KEYS
		public static const KEY_0:int 				= 48;
		public static const KEY_1:int 				= 49;
		public static const KEY_2:int 				= 50;
		public static const KEY_3:int 				= 51;
		public static const KEY_4:int 				= 52;
		public static const KEY_5:int 				= 53;
		public static const KEY_6:int 				= 54;
		public static const KEY_7:int 				= 55;
		public static const KEY_8:int 				= 56;
		public static const KEY_9:int 				= 57;

		// QWERTY ROW                           
		public static const KEY_Q:int 				= 81;
		public static const KEY_W:int 				= 87;
		public static const KEY_E:int 				= 69;
		public static const KEY_R:int 				= 82;
		public static const KEY_T:int 				= 84;
		public static const KEY_Y:int 				= 89;
		public static const KEY_U:int 				= 85;
		public static const KEY_I:int 				= 73;
		public static const KEY_O:int 				= 79;
		public static const KEY_P:int 				= 80;
		public static const KEY_BRACKET_OPEN:int 	= 219;
		public static const KEY_BRACKET_CLOSE:int 	= 221;
		public static const KEY_BACKSLASH:int		= 220;

		// ASDF ROW
		public static const KEY_A:int 				= 65;
		public static const KEY_S:int 				= 83;
		public static const KEY_D:int 				= 68;
		public static const KEY_F:int 				= 70;
		public static const KEY_G:int 				= 71;
		public static const KEY_H:int 				= 72;
		public static const KEY_J:int 				= 74;
		public static const KEY_K:int 				= 75;
		public static const KEY_L:int 				= 76;
		public static const KEY_COLON:int 			= 186;
		public static const KEY_APOSTROPHE:int 		= 222;
                                                
		// ZXCV ROW                             
		public static const KEY_Z:int 				= 90;
		public static const KEY_X:int 				= 88;
		public static const KEY_C:int 				= 67;
		public static const KEY_V:int 				= 86;
		public static const KEY_B:int 				= 66;
		public static const KEY_N:int 				= 78;
		public static const KEY_M:int 				= 77;
		public static const KEY_COMMA:int 			= 188;
		public static const KEY_PERIOD:int 			= 190;
		public static const KEY_QUESTION:int 		= 191;
		
		//========================================================
		// game input mappings..make sure you add these to _keysToWatchForPress
		//========================================================
		public static const INPUT_MOVE_LEFT:int  = KEY_A;
		public static const INPUT_MOVE_RIGHT:int = KEY_D;
		public static const INPUT_MOVE_UP:int    = KEY_W;
		public static const INPUT_MOVE_DOWN:int  = KEY_S;
		public static const INPUT_RUN:int  		= KEY_SHIFT;

		
		//============================================
		//	instance methods
		//============================================
		public static var keyDown:Array = new Array(255);
		public static var keyDoubleTap:Array = new Array(255);
		
		private static var _keyPressed:Array = new Array(255);
		private static var _keysToWatchForPress:Array = new Array(); 
		
		public static var stageRef:Stage;
		
		public static var mouse:Object = new Object();

		public static var _manageKeyboardInput:Boolean;
		public static var _manageMouseInput:Boolean;
		
		/**
		* @constructor
		*/
		public static function init(stageReference:Stage, manageKeyboardInput:Boolean = true, manageMouseInput:Boolean = true):void
		{
			stageRef = stageReference;
			_manageKeyboardInput = manageKeyboardInput;
			_manageMouseInput = manageMouseInput;
			
			if (_manageKeyboardInput)
			{
				_keysToWatchForPress.push(InputManager.INPUT_MOVE_LEFT);
				_keysToWatchForPress.push(InputManager.INPUT_MOVE_RIGHT);
				_keysToWatchForPress.push(InputManager.INPUT_MOVE_UP);
				_keysToWatchForPress.push(InputManager.INPUT_MOVE_DOWN);
			
				// key init
				for (var i:int = 0; i < keyDown.length; i++) 
				{
					keyDown[i] = false;
					keyDoubleTap[i] = false;
					_keyPressed[i] = 0;
				}
			
				stageRef.addEventListener( KeyboardEvent.KEY_DOWN, handleKeyDown );
				stageRef.addEventListener( KeyboardEvent.KEY_UP, handleKeyUp );
			}
			
			if (_manageMouseInput)
			{
				mouse.down = false;
				mouse.x = -1;
				mouse.y = -1;
				mouse.prevx = mouse.x;
				mouse.prevy = mouse.y;
				stageRef.addEventListener( MouseEvent.MOUSE_MOVE, InputManager.handleMouseMove );
				stageRef.addEventListener( MouseEvent.MOUSE_DOWN, InputManager.handleMouseDown );
				stageRef.addEventListener( MouseEvent.MOUSE_UP, InputManager.handleMouseUp );
			}
		}
		
		//============================================
		//	public methods
		//============================================
		
		public static function update():void
		{
			for (var i:int = 0; i < _keysToWatchForPress.length; i++)
			{
				//ScreenPrint.show("key :: " + _keysToWatchForPress[i] + ", _keyPressed[key] :: " + _keyPressed[_keysToWatchForPress[i]]);
				if (_keyPressed[_keysToWatchForPress[i]] != 0)
				{
					_keyPressed[_keysToWatchForPress[i]]++;
				}
			}
		}
		
		public static function keyPressed(key:int):Boolean
		{
			return (_keyPressed[key] == 1);
		}

		public static function isKeyDown(key:int):Boolean
		{
			return (_keyPressed[key] > 0);
		}

		public static function keyReleased(key:int):Boolean
		{
			return (_keyPressed[key] == -1);
		}

		public static function isKeyUp(key:int):Boolean
		{
			return (_keyPressed[key] == 0);
		}
		
		//============================================
		//	events
		//============================================
		private static function handleKeyDown(evt:KeyboardEvent):void
		{
			keyDown[evt.keyCode] = true;
			_keyPressed[evt.keyCode] = Math.max(_keyPressed[evt.keyCode], 1);
		}
		
		private static function handleKeyUp(evt:KeyboardEvent):void
		{
			//trace( evt.keyCode );
			keyDown[evt.keyCode] = false;
			_keyPressed[evt.keyCode] = -1;
		}
		
		private static function handleMouseMove(evt:MouseEvent):void
		{
			mouse.prevx = mouse.x;
			mouse.prevy = mouse.y;
			mouse.x = stageRef.mouseX;
			mouse.y = stageRef.mouseY;
		}
		
		private static function handleMouseDown(evt:MouseEvent):void
		{
			mouse.down = true;
			
			mouse.x = stageRef.mouseX;
			mouse.y = stageRef.mouseY;
			mouse.prevx = mouse.x;
			mouse.prevy = mouse.y;
		}
		
		private static function handleMouseUp(evt:MouseEvent):void
		{
			mouse.down = false;
			
			mouse.x = stageRef.mouseX;
			mouse.y = stageRef.mouseY;
			mouse.prevx = mouse.x;
			mouse.prevy = mouse.y;
		}
		
	}
}