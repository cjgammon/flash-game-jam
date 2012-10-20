/**
*	
*/
package game.entities
{	
	import flash.geom.Rectangle;

	import game.data.Player;
	import game.states.mainStates.GameplayState;
	import game.utils.GeomUtils;
	
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	*	
	*/
	public class Entity
	{
		protected var _gameState:GameplayState;
		public function get gameState():GameplayState { return _gameState; }

		//========================================================
		// position
		//========================================================
		public function get x():Number { return _sprite.x; }
		public function set x(value:Number):void 
		{ 
			rect.x = value;
			_sprite.x = value; 
		}

		public function get y():Number { return _sprite.y; }
		public function set y(value:Number):void 
		{ 
			rect.y = value;
			_sprite.y = value; 
		}

		/**
		* bounding rect, for collisions.
		*/
		public var rect:Rectangle = new Rectangle();

		public var cooldown:int = 0;
		
		//========================================================
		// rendering
		//========================================================
		/**
		* _sprite is the entire sprite, so like the dood, and any UI shit we may stick on him.
		*/
		protected var _sprite:Sprite;
		public function get sprite():Sprite { return _sprite; }
		/**
		* the body image to use.  i think for animations we should just swap textures on this _bodyImage ref
		*/
		protected var _bodyImage:Image;

		/**
		*	@constructor
		*/
		public function Entity():void
		{
			_gameState = GameplayState.instance;
			_sprite = new Sprite();
		}
		
		public function takeTurn():void
		{

		}

		/**
		* place to cleanup any junk before this thing is removed from the game forever
		*/
		public function cleanupForRemoval():void
		{
			if (_sprite.parent)
			{
				_sprite.parent.removeChild(_sprite);
			}
		}

		/**
		* reusable code for checking if two things are touching
		*/
		public function touchingEntity(entity:Entity):Boolean
		{
			return GeomUtils.rectanglesOverlap(rect, entity.rect);
		}

		/**
		* returns a list of all Player objects touching this entity
		* this is a pretty common thing to check, so let's make a handy function for it
		*/
		public function getTouchingPlayers():Array
		{
			var touchingPlayers:Array = [];

			// if we're overlapping any heroes, have the hero pick me up.
			var activeHeroes:Vector.<Player> = _gameState.activePlayers;
			var activeHeroTotal:int = activeHeroes.length;
			for (var playerIndex:int = 0; playerIndex < activeHeroTotal; playerIndex++)
			{
				var activePlayer:Player = activeHeroes[playerIndex];
				if (activePlayer.avatar != this)// can't touch yrself duh
				{
					if (touchingEntity(activePlayer.avatar))
					{
						touchingPlayers.push(activePlayer);
					}
				}
			}

			return touchingPlayers;
		}

	}
}