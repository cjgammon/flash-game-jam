/**
*	
*/
package game.entities
{	
	import game.debug.ScreenPrint;
	import game.utils.AssetLibrary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;

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
			super();

			_walkSpeed = Math.random() * .3 + .2;
			_runSpeed = _walkSpeed * 1.5;
			_movementSpeed = _walkSpeed;

			rect.width = 11;
			rect.height = 16;

			// init game layer.
			_bodyImage = new Image(AssetLibrary.enemyTextureIdle);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);	
		}

		override public function takeTurn():void
		{
			super.takeTurn();
			
			// after the enemy moves, let's see if it's touching any players.
			var touchingHeroes:Array = getTouchingPlayers();

			// just hit the first hero.
			if (touchingHeroes.length > 0)
			{
				_gameState.attackPlayer(this, touchingHeroes[0]);
			}
		}
		
	}
}