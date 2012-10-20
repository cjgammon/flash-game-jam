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
			var bulletcount:int = 1;
			var startX:Number = x + 10;
			var startY:Number = y + 10;
			var targetX:Number = InputManager.mouseX / GlobalData.SCENE_SCALE;
			var targetY:Number = InputManager.mouseY / GlobalData.SCENE_SCALE;
			var dx:Number;
			var dy:Number;
			var angle:Number;
			var bullet:Bullet;
			var speed:Number;
			
			cooldown = default_cooldown; //default cooldown

			bullet = new Bullet(this);
			
			for (var i:int = 0; i < powerups.length; i++) {
				powerup = powerups[i];
				
				if (powerup.id == "stream"){
					cooldown = 10;
				}
				
				if (powerup.id == "spread"){
					bulletcount = 3;
				}
				
				if (powerup.id == "sphere"){
					bulletcount = 8;
				}
				
				if (powerup.id == "quickbullet") {
					bullet.speed = 4;
				}
			}

			dx = targetX - startX;
			dy = targetY - startY;
			angle = Math.atan2(dy, dx);
			
			if (bulletcount == 1) {
				
				bullet.x = startX;
				bullet.y = startY;
				bullet.angle = angle;
				_gameState.spawnBullet(bullet);
				
			} else if (bulletcount == 3) {
				
				bullet = new Bullet(this, startX, startY);
				bullet.angle = angle + .2;
				_gameState.spawnBullet(bullet);
				
				bullet = new Bullet(this, startX, startY);
				bullet.angle = angle - .2;
				_gameState.spawnBullet(bullet);
				
				bullet = new Bullet(this, startX, startY);
				bullet.angle = angle;
				_gameState.spawnBullet(bullet);
				
			} else if (bulletcount == 8) {
				
				for (var j:int = 0; j < 8; j++) {
					bullet = new Bullet(this, startX, startY);
					bullet.angle = j * .8;
					_gameState.spawnBullet(bullet);
				}
				
			}
		}
	}
}