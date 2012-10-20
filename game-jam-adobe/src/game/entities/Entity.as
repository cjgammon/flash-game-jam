/**
*	
*/
package game.entities
{	
	import game.states.mainStates.GameplayState;
	
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	*	
	*/
	public class Entity
	{
		protected var _gameState:GameplayState;
		public function get gameState():GameplayState { return GameplayState.instance; }

		//========================================================
		// position
		//========================================================
		public function get x():Number { return _sprite.x; }
		public function set x(value:Number):void { _sprite.x = value; }

		public function get y():Number { return _sprite.y; }
		public function set y(value:Number):void { _sprite.y = value; }

		//========================================================
		// rendering
		//========================================================
		/**
		* _sprite is the entire sprite, so like the dood, and any UI shit we may stick on him.
		*/
		protected var _sprite:Sprite;
		public function get sprite():Sprite { return _sprite; }
		/**
		* the body image to use.  i think for animations we should just swap textures on this _bodyImage ref
		*/
		protected var _bodyImage:Image;


		/**
		*	@constructor
		*/
		public function Entity():void
		{
			_sprite = new Sprite();
		}
		
		public function takeTurn():void
		{
			
		}
	}
}