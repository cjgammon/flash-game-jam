/**
*	
*/
package game.entities
{	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.entities.controllers.IEntityController;
	import game.entities.Powerup;
	import game.utils.AssetLibrary;
	import game.utils.DebugDraw;
	import game.utils.GeomUtils;
	import game.utils.sound.SoundManager;
	import starling.display.Sprite;
	
	/**
	*	things that need to live.  they can be controlled by an IEntityController as well.
	*/
	public class LivingEntity extends Entity
	{
		//========================================================
		// stat vars
		//========================================================
		public var health:int = 100;
		public var maxHealth:int = 100;

		/**
		* whether or not this thing can be hit by bullets & explosions.
		* NOTE: this is different from being 'invincible'. if you're invincible, you can still absorb bullets, but they shouldn't harm you.
		*/
		public var canBeHit:Boolean = true;

		/**
		* no health should be logged if they're invincible.
		*/
		protected var _invincible:Boolean = false;
		public function get invincible():Boolean { return _invincible; }
		public function set invincible(value:Boolean):void
		{
			if (_invincible != value)
			{
				_invincible = value;

				if (_invincible)
				{
					// todo :: activate invincible effect
				}
				else
				{
					// todo :: deactive invincible effect
				}
			}
		}


		/**
		* how much damage something does when it touches it's target
		*/
		public var meleeDamage:int = 100;

		//========================================================
		// powerups
		//========================================================
		public var powerups:Vector.<Powerup> = new Vector.<Powerup>();
		public var powerupStackSize:uint = 3;
		public function addPowerup(powerup:Powerup):void
		{
			// remove old shit til there's enough room for new shit.
			while(powerups.length >= powerupStackSize)
			{
				powerups.shift();
			}
			powerups.push(powerup);
		}

		public function removeOldestPowerup():void
		{
			if (powerups.length > 0) powerups.shift();
		}

		public function removePowerups():void
		{
			while(powerups.length > 0) powerups.pop();
		}

		public function hasPowerupType(type:String):Boolean
		{
			for (var powerupIndex:int = 0; powerupIndex < powerups.length; powerupIndex++)
			{
				if (powerups[powerupIndex].id == type) return true;
			}
			return false;
		}

		//========================================================
		// ai/controller stuff
		//========================================================
		/**
		* target/focus.  in enemy's case, this is usually a hero, but maybe we want enemies that try to steal powerups..
		*/
		public var target:Entity;
		/**
		* 
		*/
		public var controller:IEntityController;


		//========================================================
		// movement vars
		//========================================================
		/**
		* walk speed. set in your specific classes as needed
		*/
		protected var _walkSpeed:Number = 1.0;
		/**
		* run speed. set in your specific classes as needed
		*/
		protected var _runSpeed:Number = 3.0;
		/**
		* private, it's deduced based on whether the character is running or not.
		*/
		protected var _movementSpeed:Number = _walkSpeed;
		public function get movementSpeed():Number { return _movementSpeed; }
		/**
		* set whether they're running or not. updates movement speed
		*/
		public function set isRunning(running:Boolean):void
		{
			_movementSpeed = running ? _runSpeed : _walkSpeed;
		}

		/**
		*	@constructor
		*/
		public function LivingEntity():void
		{	
			super();
		}
		
		override public function takeTurn():void
		{
			cooldown = cooldown < 0 ? 0 : cooldown - 1;
			controller.takeTurn(this);
		}

		//========================================================
		// aim/shooting
		//========================================================
		private var _aimRadians:Number = 0.0;
		public function lookAt(x:int, y:int):void
		{
			_aimRadians = Math.atan2(y - _sprite.y, x - _sprite.y);
			//_sprite.rotation = _aimRadians;

			/*
			DebugDraw.canvas.graphics.clear();
			DebugDraw.canvas.graphics.lineStyle(1, 0xff0000);
			DebugDraw.canvas.graphics.moveTo(_sprite.x, _sprite.y);
			DebugDraw.canvas.graphics.lineTo(x, y);
			*/
		}

		public function lookAtEntity(targetEntity:Entity):void
		{
			
		}

		public function shootAt(targetX:Number, targetY:Number):void
		{
			if (cooldown == 0)
			{
				var powerup:Powerup;
				var spreadsize:Number;
				var bulletcount:int = 1;
				var startX:Number = x;
				var startY:Number = y;
				var targetX:Number = targetX;
				var targetY:Number = targetY;
				var dx:Number;
				var dy:Number;
				var angle:Number;
				var bullet:Bullet;
				var speed:Number;
				
				cooldown = default_cooldown; //default cooldown

				bullet = new Bullet(this, startX, startY);
				
				var activePowerupCount:int = powerups.length;
				for (var powerupIndex:int = 0; powerupIndex < activePowerupCount; powerupIndex++)
				{
					powerup = powerups[powerupIndex];
					
					if (powerup.id == Powerup.TYPE_STREAM){
						cooldown = 3;
					}
					
					if (powerup.id == Powerup.TYPE_SPREAD){
						bulletcount = 3;
					}
					
					if (powerup.id == Powerup.TYPE_SPHERE){
						bulletcount = 8;
					}
					
					if (powerup.id == Powerup.TYPE_QUICKBULLET) {
						bullet.speed = 4;
					}
					
					if (powerup.id == Powerup.TYPE_SILVERBULLET) {
						bullet.silver = true;
					}

					if (powerup.id == Powerup.TYPE_RUBBER_BULLET) {
						bullet.bounces = 10;// 10 bounces for now
					}
					
					if (powerup.id == Powerup.TYPE_EXPLOSIVE) {
						bullet.explosive = true;
					}
				}

				dx = targetX - startX;
				dy = targetY - startY;
				angle = Math.atan2(dy, dx);
				
				if (bulletcount == 1) {
					SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerShoot)());

					bullet.angle = angle;
					_gameState.spawnBullet(bullet);
					
				} else if (bulletcount == 3) {
					SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerShoot2)());

					bullet = new Bullet(this, startX, startY);
					bullet.angle = angle + .2;
					_gameState.spawnBullet(bullet);
					
					bullet = new Bullet(this, startX, startY);
					bullet.angle = angle - .2;
					_gameState.spawnBullet(bullet);
					
					bullet = new Bullet(this, startX, startY);
					bullet.angle = angle;
					_gameState.spawnBullet(bullet);
					
				} else if (bulletcount == 8) {
					SoundManager.instance.vPlaySound(new (AssetLibrary.PlayerShoot3)());

					for (var j:int = 0; j < 8; j++) {
						bullet = new Bullet(this, startX, startY);
						bullet.angle = j * .8;
						_gameState.spawnBullet(bullet);
					}
					
				}
			}
		}

		public function shootAtTarget(targetEntity:Entity):void
		{
			// todo :: lead shot?
			var centerPoint:Point = targetEntity.getCenterPoint();
			shootAt(centerPoint.x, centerPoint.y);
		}

		//========================================================
		// bombs
		//========================================================
		/**
		* bombs are an attack that kills anything within a radius around you.
		*/
		public var bombs:int = 0;
		public var bombRadius:Number = 50;
		public var bombDamage:Number = 200;
		/**
		* how much it costs this guy to buy more bombs.
		*/
		public var bombCost:int = 3;

		public function useBomb():void
		{
			// ask gamestate if we can use a bomb, it'll figure out what to do.
			if (_gameState.tryToUseBomb(this))
			{
				// mark down where our center is.
				var centerPoint:Point = getCenterPoint();

				var enemies:Dictionary = _gameState.enemies;
				for each (var enemy:Enemy in _gameState.enemies)
				{
					if (enemy.canBeHit)
					{
						if (GeomUtils.rectangleOverlapsCircle(enemy.rect, centerPoint.x, centerPoint.y, bombRadius))
						{
							_gameState.bombHitEnemy(this, enemy);
						}
					}
				}
			}
		}
	}
}