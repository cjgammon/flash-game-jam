/**
*	
*/
package game.entities.controllers
{	
	import game.entities.LivingEntity;
	import starling.display.Sprite;
	
	/**
	*	
	*/
	public class AIControllerBasic extends EntityController implements IEntityController
	{
		
		/**
		*	@constructor
		*/
		public function AIControllerBasic():void
		{
			
		}
		
		override public function takeTurn(entity:LivingEntity):void
		{
			// if they have a target, do something!
			if (entity.target != null)
			{
				var sprite:Sprite = entity.sprite;
				var speed:Number = entity.movementSpeed;

				// just move around randomly for now :)
				//sprite.x += Math.random() * 2 - 1;
				//sprite.y += Math.random() * 2 - 1;
				//trace(speed);
				
				if (sprite.x < entity.target.sprite.x) {
					sprite.x += speed;
				} else if (sprite.x > entity.target.sprite.x) {
					sprite.x -= speed;
				}
				
				if (sprite.y < entity.target.sprite.y) {
					sprite.y += speed;
				} else if(sprite.y > entity.target.sprite.y) {
					sprite.y -= speed;
				}
			}
			// if we don't have a target, figure out what to do.  
			else
			{
				// pick a new target? get bored?

			}
		}
	}
}