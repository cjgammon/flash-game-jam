/**
*	
*/
package game.entities
{	
	import flash.utils.Dictionary;
	
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

		private var _shooter:Entity;
		public function get shooter():Entity { return _shooter; }
		public var damage:int = 100;
		
		/**
		*	@constructor
		*/
		public function Bullet(shooter:Entity, startX:Number, startY:Number, goalX:Number, goalY:Number):void
		{
			super();

			_shooter = shooter;

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
			_vx = Math.cos(angle);
			_vy = Math.sin(angle);
		}
		
		public function update():void
		{
			_sprite.x += _vx;
			_sprite.y += _vy;

			// see if the bullet is hitting any enemies.  
			// this is probably going to be pretty cpu intensive if we have lots of enemies, we may want to put bullets & enemies in a grid, so we only need to check against enemies in our current tile
			// & if we want enemies to shoot things, we should also have some way of making that happen
			var enemies:Dictionary = _gameState.enemies;
			for each (var enemy:Enemy in _gameState.enemies)
			{
				if (touchingEntity(enemy))
				{
					if (_gameState.bulletHitEnemy(this, enemy))
					{
						break; 
					}
				}
			}
		}
	}
}