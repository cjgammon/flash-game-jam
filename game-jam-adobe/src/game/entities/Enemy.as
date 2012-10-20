/**
*	
*/
package game.entities
{	
	import game.utils.AssetLibrary;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	*	base class for enemies.  if you want to make a new enemy, make a new class type for it.  we'll keep basic functionality in here for common AI and stuff
	*/
	public class Enemy extends LivingEntity
	{
		/**
		*	@constructor
		*/
		public function Enemy():void
		{
			// init game layer.
			_bodyImage = new Image(AssetLibrary.enemyTextureIdle);
			_sprite.addChild(_bodyImage);
		}
		
		/**
		* 
		*/
		public function takeTurn():void
		{
			// if they have a target, do something!
			if (target != null)
			{
				// just move around randomly for now :)
				_sprite.x += Math.random() * 2 - 1;
				_sprite.y += Math.random() * 2 - 1;
			}
			// if we don't have a target, figure out what to do.  
			else
			{
				// pick a new target? get bored?
			}
		}
	}
}