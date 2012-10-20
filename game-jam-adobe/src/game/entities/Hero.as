/**
*	
*/
package game.entities
{	
	import game.data.GlobalData;
	import game.utils.AssetLibrary;
	import game.utils.InputManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;

	/**
	*	things that need to live
	*/
	public class Hero extends LivingEntity
	{
		/**
		*	@constructor
		*/
		public function Hero():void
		{
			super();

			rect.width = 11;
			rect.height = 16;

			// init game layer.
			_bodyImage = new Image(AssetLibrary.heroTextureIdle);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
			
			//TODO :: follow character
			// big money, big prizes.
			var moneyEmitter:MoneyEmitter = new MoneyEmitter();
			moneyEmitter.sprite.x = 10;
			moneyEmitter.sprite.y = 10;
			moneyEmitter.start();
			_sprite.addChild(moneyEmitter.sprite);
		}
		
		override public function shoot():void
		{
			var powerup:Powerup;
			var spreadsize:Number;
			var multiplebullets:Boolean = false;
			var targetX:Number = InputManager.mouseX / GlobalData.SCENE_SCALE;
			var targetY:Number = InputManager.mouseY / GlobalData.SCENE_SCALE;
			
			cooldown = default_cooldown; //default cooldown

			for (var i:int; i < powerups.length; i++) {
				powerup = powerups[i];
				
				if (powerup.id == "stream"){
					cooldown = 0;
				}
				
				if (powerup.id == "spread"){
					multiplebullets = true;
					spreadsize = 100;
				}
			}

			if (!multiplebullets) {
				_gameState.spawnBullet(this, x + 10, y + 10, targetX, targetY);
			} else {
				_gameState.spawnBullet(this, x + 10, y + 10, targetX, targetY);
				_gameState.spawnBullet(this, x + 10, y + 10, targetX + spreadsize, targetY + spreadsize);
				_gameState.spawnBullet(this, x + 10, y + 10, targetX - spreadsize, targetY - spreadsize);
			}
		}
		
		
	}
}