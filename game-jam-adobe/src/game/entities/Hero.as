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
	}
}