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
			var activeHeroes:Vector.<Player> = _gameState.activePlayers;
			var activeHeroTotal:int = activeHeroes.length;
			for (var playerIndex:int = 0; playerIndex < activeHeroTotal; playerIndex++)
			{
				var activePlayer:Player = activeHeroes[playerIndex];
				if (GeomUtils.rectanglesOverlap(rect, activePlayer.avatar.rect))
				{
					_gameState.acquirePowerup(activePlayer.avatar, this);
				}
			}
		}
		
	}
}