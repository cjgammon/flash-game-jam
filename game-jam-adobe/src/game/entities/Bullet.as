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
		private var _vx:Number = 1;
		private var _vy:Number = 1;

		/**
		*	@constructor
		*/
		public function Bullet():void
		{
			// init game layer.
			_bodyImage = new Image(AssetLibrary.bulletTexture);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
		}
		
		public function update():void
		{
			_sprite.x += _vx;
			_sprite.y += _vy;
		}
	}
}