/**
*	
*/
package game.entities
{	
	import game.utils.AssetLibrary;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	*	base class for enemies.  if you want to make a new enemy, make a new class type for it.  we'll keep basic functionality in here for AI and stuff
	*/
	public class Enemy extends Entity
	{
		/**
		*	@constructor
		*/
		public function Enemy():void
		{
			// init game layer.
			_bodyImage = new Image(AssetLibrary.heroTextureIdle);
			_sprite.addChild(_bodyImage);
		}
		
		
	}
}