/**
*	
*/
package game.data
{	
	import game.data.PlayerData;
	
	/**
	*	
	*/
	public class GameData 
	{
		public static const MAX_PLAYERS:int = 4;
		public var players:Vector.<PlayerData> = new Vector.<PlayerData>(MAX_PLAYERS);

		/**
		*	@constructor
		*/
		public function GameData():void
		{
			
		}
		
		public function setPlayerType(playerIndex:int, playerType:int):void
		{
			if (0 <= playerIndex && playerIndex < MAX_PLAYERS)
			{
				players[playerIndex] = new PlayerData(playerType);
			}
		}		
	}
}