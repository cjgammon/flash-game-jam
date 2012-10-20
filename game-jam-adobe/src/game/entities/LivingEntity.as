/**
*	
*/
package game.entities
{	
	import starling.display.Sprite;
	
	/**
	*	things that need to live
	*/
	public class LivingEntity extends Entity
	{
		public var health:int = 100;
		public var maxHealth:int = 100;

		/**
		* walk speed. set in your specific classes as needed
		*/
		protected var _walkSpeed:Number = 1.0;
		/**
		* run speed. set in your specific classes as needed
		*/
		protected var _runSpeed:Number = 3.0;
		/**
		* private, it's deduced based on whether the character is running or not.
		*/
		private var _movementSpeed:Number = _walkSpeed;
		public function get movementSpeed():Number { return _movementSpeed; }
		/**
		* set whether they're running or not. updates movement speed
		*/
		public function set isRunning(running:Boolean):void
		{
			_movementSpeed = running ? _runSpeed : _walkSpeed;
		}
		
		/**
		*	@constructor
		*/
		public function LivingEntity():void
		{
			
		}
		
		
	}
}