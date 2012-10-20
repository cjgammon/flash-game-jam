/**
*	
*/
package game.data
{	
	import game.entities.LivingEntity;

	/**
	*	this represents one local/remote human or AI player
	*/
	public class Player
	{
		//========================================================
		// player types
		//========================================================
		public static const TYPE_INVALID:int = -1;
		public static const TYPE_HUMAN_LOCAL:int = 0;
		public static const TYPE_HUMAN_REMOTE:int = 1;
		public static const TYPE_AI:int = 2;

		//========================================================
		// character types
		//========================================================
		public static const CHARACTER_TYPE_DEFAULT:int = 0;
		
		//========================================================
		// 
		//========================================================
		public var playerType:int = TYPE_INVALID;
		public var characterType:int = CHARACTER_TYPE_DEFAULT;
		public var avatar:LivingEntity;

		//========================================================
		// stats!
		//========================================================
		public var score:int = 0;
		public var kills:int = 0;
		public var pickups:int = 0;
		
		/**
		*	@constructor
		*/
		public function Player(playerType:int, characterType:int):void
		{
			this.playerType = playerType;
			this.characterType = characterType;
		}
	}
}