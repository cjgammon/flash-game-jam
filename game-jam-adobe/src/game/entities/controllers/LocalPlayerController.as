/**
*	
*/
package game.entities.controllers
{	
	import game.data.GlobalData;
	import game.entities.Bullet;
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
			//========================================================
			// movement
			//========================================================
			// check if they're running

			
			if (entity.health < 1) {
				return;  // only let them go if their still alive.
			}
			
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
				entity.sprite.scaleX = -1;
				entity.x -= entity.movementSpeed;
			}
			else if (InputManager.isKeyDown(InputManager.INPUT_MOVE_RIGHT))
			{
				entity.sprite.scaleX = 1;
				entity.x += entity.movementSpeed;
			}
			
			if (InputManager.isKeyDown(InputManager.INPUT_MOVE_UP))
			{
				entity.y = Math.max(entity.y - entity.movementSpeed, GlobalData.STAGE_ROOF_EDGE);
			}
			else if (InputManager.isKeyDown(InputManager.INPUT_MOVE_DOWN))
			{
				entity.y += entity.movementSpeed;
			}

			//========================================================
			// aim
			//========================================================
			entity.lookAt(InputManager.mouseX, InputManager.mouseY);
			if (InputManager.mouseDown()) 
			{
				entity.shootAt(InputManager.mouseX / GlobalData.SCENE_SCALE, InputManager.mouseY / GlobalData.SCENE_SCALE);
			}

			//========================================================
			// bomb controls
			//========================================================
			if (InputManager.keyPressed(InputManager.INPUT_BOMB))
			{
				entity.useBomb();
			}
		}
		
	}
}