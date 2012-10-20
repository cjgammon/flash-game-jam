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
		public var speed:Number = 0.2 + Math.random() * 0.6;
		
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
		
		/**
		* todo :: hook up a controller class that handles the turn for this thing.  we shouldn't actually care about how controls this thing, whether it's an enemy or whatever.  we really only care about it's stats and what whoever is controlling it thinks it should do.
		*/
		override public function takeTurn():void
		{
			// if they have a target, do something!
			if (target != null)
			{
				// just move around randomly for now :)
				//_sprite.x += Math.random() * 2 - 1;
				//_sprite.y += Math.random() * 2 - 1;
				//trace(speed);
				
				if (_sprite.x < target.sprite.x) {
					_sprite.x += speed;
				} else if (_sprite.x > target.sprite.x) {
					_sprite.x -= speed;
				}
				
				if (_sprite.y < target.sprite.y) {
					_sprite.y += speed;
				} else if(_sprite.y > target.sprite.y) {
					_sprite.y -= speed;
				}
			}
			// if we don't have a target, figure out what to do.  
			else
			{
				// pick a new target? get bored?
			}
		}
	}
}