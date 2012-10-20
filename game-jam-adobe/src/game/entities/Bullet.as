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

		public var goalX:Number;
		public var goalY:Number;
		
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
		
		public function update():void
		{
			var dy:Number = goalY - y;
			var dx:Number = goalX - x;
			var angle:Number = Math.abs(Math.atan2(dy, dx)) * (180 / Math.PI);
			
			trace("update");
			_vx = 1 * Math.cos(angle);
			_vy = 1 * Math.sin(angle);
			_sprite.x += _vx;
			_sprite.y += _vy;
		}
	}
}