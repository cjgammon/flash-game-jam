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
		private var _vx:Number;
		private var _vy:Number;

		public var goalX:Number;
		public var goalY:Number;
		
		/**
		*	@constructor
		*/
		public function Bullet(startX:Number, startY:Number, goalX:Number, goalY:Number):void
		{
			super();

			x = startX;
			y = startY;
			
			rect.width = 2;
			rect.height = 2;

			// init game layer.
			_bodyImage = new Image(AssetLibrary.bulletTexture);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
			
			var dx:Number = goalX - startX;
			var dy:Number = goalY - startY;
			var angle:Number = Math.atan2(dy, dx);
			trace(startX, goalX, angle);
			_vx = Math.cos(angle);
			_vy = Math.sin(angle);
		}
		
		public function update():void
		{
			_sprite.x += _vx;
			_sprite.y += _vy;
		}
	}
}