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
				entity.lookAtEntity(entity.target);

				var targetSprite:Sprite = entity.target.sprite;
				var speed:Number = entity.movementSpeed;

				// just move around randomly for now :)
				//sprite.x += Math.random() * 2 - 1;
				//sprite.y += Math.random() * 2 - 1;
				//trace(speed);
				
				if (entity.x < targetSprite.x) {
					entity.x += speed;
				} else if (entity.x > targetSprite.x) {
					entity.x -= speed;
				}
				
				if (entity.y < targetSprite.y) {
					entity.y += speed;
				} else if(entity.y > targetSprite.y) {
					entity.y -= speed;
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