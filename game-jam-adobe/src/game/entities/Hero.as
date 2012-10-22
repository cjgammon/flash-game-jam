/**
*	
*/
package game.entities
{	
	import game.data.GlobalData;
	import game.utils.AssetLibrary;
	import game.utils.InputManager;
	import game.entities.MoneyEmitter;
	import game.utils.sound.SoundManager;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;

	/**
	*	things that need to live
	*/
	public class Hero extends LivingEntity
	{
		private var moneyEmitter:MoneyEmitter;
		private var _hit:Boolean = false;
		
		/**
		*	@constructor
		*/
		public function Hero():void
		{
			super();

			//_invincible = true;

			rect.width = 11;
			rect.height = 16;

			// init game layer.
			_bodyImage = new Image(AssetLibrary.heroTextureIdle);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_bodyImage.x = -rect.width / 2;  //offset for center 
			_bodyImage.y = -rect.height / 2;
			_sprite.addChild(_bodyImage);
		
			// big money, big prizes.
			moneyEmitter = new MoneyEmitter();
			sprite.addChild(moneyEmitter.sprite);
		}
		
		public function hit():void
		{
			if (_hit == false) {
				SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerHit)());
			}
			_hit = true;
			moneyEmitter.start();	
		}
		
		override public function shoot():void
		{
			var powerup:Powerup;
			var spreadsize:Number;
			var bulletcount:int = 1;
			var startX:Number = x;
			var startY:Number = y;
			var targetX:Number = InputManager.mouseX / GlobalData.SCENE_SCALE;
			var targetY:Number = InputManager.mouseY / GlobalData.SCENE_SCALE;
			var dx:Number;
			var dy:Number;
			var angle:Number;
			var bullet:Bullet;
			var speed:Number;
			
			cooldown = default_cooldown; //default cooldown
			bullet = new Bullet(this, startX, startY);
			
			for (var i:int = 0; i < powerups.length; i++) {

				powerup = powerups[i];
				trace('powerups', i, powerup.id);
				
				switch (powerup.id) {
					case Powerup.TYPE_STREAM:
						cooldown = 3;
						break;
					case Powerup.TYPE_SPREAD:
						bulletcount = 3;
						break;
					case Powerup.TYPE_SPHERE:
						bulletcount = 8;
						break;
					case Powerup.TYPE_QUICKBULLET:
						bullet.speed = 4;
						break;
					case Powerup.TYPE_SILVERBULLET:
						bullet.silver = true;		
						break;
				}
			}

			dx = targetX - startX;
			dy = targetY - startY;
			angle = Math.atan2(dy, dx);
			
			if (bulletcount == 1) {
				SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerShoot)());

				bullet.angle = angle;
				_gameState.spawnBullet(bullet);
				
			} else if (bulletcount == 3) {
				SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerShoot2)());

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
				SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerShoot3)());

				for (var j:int = 0; j < 8; j++) {
					bullet = new Bullet(this, startX, startY);
					bullet.angle = j * .8;
					_gameState.spawnBullet(bullet);
				}
				
			}
		}
	}
}