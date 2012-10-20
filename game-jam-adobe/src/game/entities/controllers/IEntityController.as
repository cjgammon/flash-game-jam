/**
*	
*/
package game.entities.controllers
{	
	import game.entities.LivingEntity;
	
	/**
	*	
	*/
	public interface IEntityController 
	{
		function takeTurn(entity:LivingEntity):void;
	}
}