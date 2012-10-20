/**
*	
*/
package game.entities
{	
	import starling.display.Sprite;
	import game.entities.controllers.IEntityController;
	
	/**
	*	things that need to live.  they can be controlled by an IEntityController as well.
	*/
	public class LivingEntity extends Entity
	{
		//========================================================
		// health vars
		//========================================================
		public var health:int = 100;
		public var maxHealth:int = 100;

		//========================================================
		// ai/controller stuff
		//========================================================
		/**
		* target/focus.  in enemy's case, this is usually a hero, but maybe we want enemies that try to steal powerups..
		*/
		public var target:Entity;
		/**
		* 
		*/
		public var controller:IEntityController;


		//========================================================
		// movement vars
		//========================================================
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
		
		override public function takeTurn():void
		{
			controller.takeTurn(this);
		}
	}
}