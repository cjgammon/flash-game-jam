/**
*	
*/
package game.entities.controllers
{	
	import flash.utils.Dictionary;
	import game.entities.LivingEntity;
	import game.entities.controllers.*;

	/**
	*	
	*/
	public class EntityController implements IEntityController
	{
		//========================================================
		// entity controller hash.
		// so we don't have a million controllers, let's just have a hash that keeps track of each unique controller type.
		//========================================================
		private static var _controllerTypes:Dictionary = new Dictionary();
		public static function getControllerType(klass:Class):IEntityController
		{
			if (!_controllerTypes[klass]) _controllerTypes[klass] = new klass();
			return _controllerTypes[klass];
		}

		/**
		*	@constructor
		*/
		public function EntityController():void
		{
			
		}
		
		public function takeTurn(entity:LivingEntity):void
		{
			// override me
		}
	}
}