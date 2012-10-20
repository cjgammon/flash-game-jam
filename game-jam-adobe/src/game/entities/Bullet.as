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
	*	base class for bullets.  I think right now we'll probably end up just having one bullet class to rule them all, but the powerups will be able to mutate their properties somehow.
	*/
	public class Bullet extends Entity
	{
		
		/**
		*	@constructor
		*/
		public function Bullet():void
		{
			super();

			rect.width = 2;
			rect.height = 2;

			// init game layer.
			_bodyImage = new Image(AssetLibrary.bulletTexture);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
		}
		
	}
}