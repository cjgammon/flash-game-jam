/**
*	
*/
package game.entities
{	
	import game.utils.AssetLibrary;
	import starling.display.Image;
	import starling.display.Sprite;
	
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
			// init game layer.
			_bodyImage = new Image(AssetLibrary.heroTextureIdle);
			_sprite.addChild(_bodyImage);
		}
		
		
	}
}