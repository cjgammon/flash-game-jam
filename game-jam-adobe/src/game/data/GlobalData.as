/**
*	
*/
package game.data
{	
	/**
	*	
	*/
	public class GlobalData 
	{
		public static const MODE_DEBUG:int = 0;
		public static const MODE_RELEASE:int = 1;
		public static const CURRENT_MODE:int = MODE_DEBUG;
		public static function get RELEASE():Boolean { return CURRENT_MODE == MODE_RELEASE; }
		public static function get DEBUG():Boolean { return CURRENT_MODE == MODE_DEBUG; }

	}
}