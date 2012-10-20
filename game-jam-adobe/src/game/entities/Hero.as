/**
*	
*/
package game.entities
{	
	import game.utils.AssetLibrary;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;
	
	import game.utils.InputManager;

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
			var y1:Number = _sprite.y;
			var y2:Number = InputManager.mouseY;
			var x1:Number = _sprite.x;
			var x2:Number = InputManager.mouseX;
			var dy:Number = y2 - y1;
			var dx:Number = x2 - x1;
			
			var angle:Number = Math.abs(Math.atan2((y1-y2),(x1-x2)))*(180/Math.PI)
			gameState.spawnBullet(_sprite.x, _sprite.y, angle);
		}
		
	}
}