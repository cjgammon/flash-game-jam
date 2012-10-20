/**
*	
*/
package game.entities.controllers
{	
	import game.entities.LivingEntity;
	import game.utils.InputManager;
	
	/**
	*	
	*/
	public class LocalPlayerController extends EntityController implements IEntityController
	{
		
		/**
		*	@constructor
		*/
		public function LocalPlayerController():void
		{
			
		}

		override public function takeTurn(entity:LivingEntity):void
		{
			// check if they're running
			if (InputManager.keyPressed(InputManager.INPUT_RUN))
			{
				entity.isRunning = true;
			}
			else if (InputManager.keyReleased(InputManager.INPUT_RUN))
			{
				entity.isRunning = false;
			}

			if (InputManager.isKeyDown(InputManager.INPUT_MOVE_LEFT))
			{
				entity.sprite.x -= entity.movementSpeed;
			}
			else if (InputManager.isKeyDown(InputManager.INPUT_MOVE_RIGHT))
			{
				entity.sprite.x += entity.movementSpeed;
			}
			if (InputManager.isKeyDown(InputManager.INPUT_MOVE_UP))
			{
				entity.sprite.y -= entity.movementSpeed;
			}
			else if (InputManager.isKeyDown(InputManager.INPUT_MOVE_DOWN))
			{
				entity.sprite.y += entity.movementSpeed;
			}
		}
	}
}