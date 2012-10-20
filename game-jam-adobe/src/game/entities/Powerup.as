/**
*	
*/
package game.entities
{	
	import game.data.Player;
	import game.states.mainStates.GameplayState;
	import game.utils.AssetLibrary;
	import starling.display.Image;
	import starling.textures.TextureSmoothing;

	/**
	*	
	*/
	public class Powerup extends Entity
	{
		
		/**
		*	@constructor
		*/
		public function Powerup():void
		{
			super();

			_bodyImage = new Image(AssetLibrary.placeholderPowerupTexture);
			_bodyImage.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_bodyImage);
		}
		
		override public function takeTurn():void
		{
			// if we're overlapping any heroes, have the hero pick me up.
			var activeHeros:Vector.<Player> = _gameState.activePlayers;
		}
		
	}
}