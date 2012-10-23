/**
*	
*/
package game.utils
{	
	import flash.geom.Rectangle;

	/**
	*	
	*/
	public class GeomUtils 
	{
		
		public static function coordinatesInRect(x:Number, y:Number, rect:Rectangle):Boolean
		{
			if (x >= rect.x && x <= rect.x + rect.width && y >= rect.y && y <= rect.y + rect.height) return true;
			return false;
		}

		public static function rectanglesOverlap(rect1:Rectangle, rect2:Rectangle):Boolean
		{
			if (coordinatesInRect(rect1.x, rect1.y, rect2)) return true;
			if (coordinatesInRect(rect1.x + rect1.width, rect1.y, rect2)) return true;
			if (coordinatesInRect(rect1.x + rect1.width, rect1.y + rect1.height, rect2)) return true;
			if (coordinatesInRect(rect1.x, rect1.y + rect1.height, rect2)) return true;
			return false;
		}

		public static function rectangleOverlapsCircle(rect:Rectangle, circleX:Number, circleY:Number, circleRadius:Number):Boolean
		{
			if (coordinatesInCircle(rect.x, rect.y, circleX, circleY, circleRadius)) return true;
			if (coordinatesInCircle(rect.x + rect.width, rect.y, circleX, circleY, circleRadius)) return true;
			if (coordinatesInCircle(rect.x + rect.width, rect.y + rect.height, circleX, circleY, circleRadius)) return true;
			if (coordinatesInCircle(rect.x, rect.y + rect.height, circleX, circleY, circleRadius)) return true;
			return false;
		}

		public static function coordinatesInCircle(x:Number, y:Number, circleX:Number, circleY:Number, circleRadius:Number):Boolean
		{
			var dx:Number = x - circleX;
			var dy:Number = y - circleY;
			return circleRadius*circleRadius >= dx*dx + dy*dy;
		}
	}
}