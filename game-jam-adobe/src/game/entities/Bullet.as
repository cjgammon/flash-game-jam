/**
*	
*/
package game.entities
{	
	import flash.utils.Dictionary;
	
	import game.data.GlobalData;
	import game.debug.ScreenPrint;
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
		private var _shooter:Entity;
		private var _angle:Number;

		public var speed:Number = 2;
		public var silver:Boolean = false;
		/**
		* how many bounces this bullet can still take along its trajectory
		*/
		public var bounces:uint = 0;
		
		public function get shooter():Entity { return _shooter; }
		public var damage:int = 100;
		
		/**
		*	@constructor
		*/
		public function Bullet(shooter:Entity, startX:Number = 0, startY:Number = 0):void
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
		}
		
		public function set angle(newAngle:Number):void 
		{
			_angle = newAngle;
			_vx = Math.cos(_angle);
			_vy = Math.sin(_angle);
		}
		
		override public function takeTurn():void
		{
			x += _vx * speed;
			y += _vy * speed;

			// if we're offscreen, remove us.
			if (x < 0 - rect.width || x > GlobalData.SCENE_WIDTH || y < 0 - rect.height || y > GlobalData.SCENE_HEIGHT)
			{
				_gameState.removeBullet(this);
				return;
			}

			// see if the bullet is hitting any enemies.  
			// this is probably going to be pretty cpu intensive if we have lots of enemies, we may want to put bullets & enemies in a grid, so we only need to check against enemies in our current tile
			// & if we want enemies to shoot things, we should also have some way of making that happen
			var enemies:Dictionary = _gameState.enemies;
			for each (var enemy:Enemy in _gameState.enemies)
			{
				if (enemy.canBeHit)// make sure this bullet can even hit him.
				{
					if (touchingEntity(enemy))
					{
						if (_gameState.bulletHitEnemy(this, enemy))
						{
							// get out of here. if it's not silver.
							if (!silver) return;
						}
					}
				}
			}
		}
	}
}