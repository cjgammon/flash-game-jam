/**
*	
*/
package game.utils
{	
	import flash.display.Bitmap;
	import starling.textures.Texture;

	/**
	*	
	*/
	public class AssetLibrary
	{
		//========================================================
		// hero texture
		//========================================================
		[Embed(source="./assets/hero.png")]
		private static var HeroSprite:Class;
		public static var heroSpriteBmp:Bitmap = new HeroSprite();		
		public static var heroTextureIdle:Texture = Texture.fromBitmap(heroSpriteBmp);




	}
}