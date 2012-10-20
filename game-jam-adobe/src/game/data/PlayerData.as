/**
*	
*/
package game.data
{	
	import game.entities.LivingEntity;

	/**
	*	this represents one local/remote human or AI player
	*/
	public class PlayerData
	{
		public static const TYPE_INVALID:int = -1;
		public static const TYPE_HUMAN_LOCAL:int = 0;
		public static const TYPE_HUMAN_REMOTE:int = 1;
		public static const TYPE_AI:int = 2;
		
		public var playerType:int = TYPE_INVALID;
		public var avatar:LivingEntity;
		public var score:int = 0;
		
		/**
		*	@constructor
		*/
		public function PlayerData(playerType:int):void
		{
			this.playerType = playerType;
		}
	}
}