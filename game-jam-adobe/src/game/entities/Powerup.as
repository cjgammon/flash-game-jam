/**
*	
*/
package game.entities
{	
	import game.data.Player;
	import game.states.mainStates.GameplayState;
	import game.utils.AssetLibrary;
	import game.utils.GeomUtils;
	
	import starling.display.Image;
	import starling.textures.TextureSmoothing;

	/**
	*	
	*/
	public class Powerup extends Entity
	{
		public var id:String;
		
		/**
		*	@constructor
		*/
		public function Powerup():void
		{
			super();

			rect.width = 4;
			rect.height = 6;

			_bodyImage = new Image(AssetLibrary.placeholderPowerupTexture);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
		}
		
		override public function takeTurn():void
		{
			// if we're overlapping any heroes, have the hero pick me up.
			var touchingHeroes:Array = getTouchingPlayers();

			// just give it to the first hero.
			if (touchingHeroes.length > 0)
			{
				_gameState.acquirePowerup(touchingHeroes[0].avatar, this);
			}
		}
		
	}
}