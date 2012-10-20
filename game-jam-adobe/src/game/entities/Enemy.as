/**
*	
*/
package game.entities
{	
	import game.utils.AssetLibrary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;

	/**
	*	base class for enemies.  if you want to make a new enemy, make a new class type for it.  we'll keep basic functionality in here for common AI and stuff
	*/
	public class Enemy extends LivingEntity
	{
		public var enemySpeed:Number = .2 + Math.random() * .8;
		
		/**
		*	@constructor
		*/
		public function Enemy():void
		{
			// init game layer.
			_bodyImage = new Image(AssetLibrary.enemyTextureIdle);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
			
		}
		
		override public function get movementSpeed():Number { return enemySpeed; }
	}
}