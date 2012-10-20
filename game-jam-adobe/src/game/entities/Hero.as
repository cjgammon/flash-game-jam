/**
*	
*/
package game.entities
{	
	import game.utils.AssetLibrary;
	import game.utils.InputManager;
	import game.data.GlobalData;
	
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
			cooldown = 5;
			_gameState.spawnBullet(x + 10, y + 10, InputManager.mouseX / GlobalData.SCENE_SCALE, InputManager.mouseY / GlobalData.SCENE_SCALE);
		}
		
		
	}
}