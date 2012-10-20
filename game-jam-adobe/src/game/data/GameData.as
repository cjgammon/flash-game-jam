/**
*	
*/
package game.data
{	
	import game.data.Player;
	
	/**
	*	
	*/
	public class GameData 
	{
		public static const MAX_PLAYERS:int = 4;
		public var players:Vector.<Player> = new Vector.<Player>(MAX_PLAYERS);

		/**
		*	@constructor
		*/
		public function GameData():void
		{
			
		}
		
		public function setPlayerType(playerIndex:int, playerType:int, characterType:int):void
		{
			if (0 <= playerIndex && playerIndex < MAX_PLAYERS)
			{
				players[playerIndex] = new Player(playerType, characterType);
			}
		}		
	}
}