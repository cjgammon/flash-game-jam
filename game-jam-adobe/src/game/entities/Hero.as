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
			var startX:Number = x + 10;
			var startY:Number = y + 10;
			var targetX:Number = InputManager.mouseX / GlobalData.SCENE_SCALE;
			var targetY:Number = InputManager.mouseY / GlobalData.SCENE_SCALE;
			var dx:Number;
			var dy:Number;
			var angle:Number;
			
			cooldown = default_cooldown; //default cooldown

			for (var i:int; i < powerups.length; i++) {
				powerup = powerups[i];
				
				if (powerup.id == "stream"){
					cooldown = 10;
				}
				
				if (powerup.id == "spread"){
					multiplebullets = true;
					spreadsize = 100;
				}
			}

			if (!multiplebullets) {
				dx = targetX - startX;
				dy = targetY - startY;
				angle = Math.atan2(dy, dx);
				
				_gameState.spawnBullet(this, startX, startY, angle);
			} else {
				dx = targetX - startX;
				dy = targetY - startY;
				angle = Math.atan2(dy, dx);
				_gameState.spawnBullet(this, startX, startY, angle + .2);
				_gameState.spawnBullet(this, startX, startY, angle - .2);
				_gameState.spawnBullet(this, startX, startY, angle);

			}
		}
		
		
	}
}