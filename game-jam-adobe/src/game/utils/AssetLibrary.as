/**
*	
*/
package game.utils
{	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

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


		//========================================================
		// enemy texture
		//========================================================
		[Embed(source="./assets/enemy.png")]
		private static var EnemySprite:Class;
		public static var enemySpriteBmp:Bitmap = new EnemySprite();		
		public static var enemyTextureIdle:Texture = Texture.fromBitmap(enemySpriteBmp);

		//========================================================
		// particle texture
		//========================================================
		[Embed(source="./assets/money_particle/texture.png")]
		public static var MoneyParticleTexture:Class;
		
		//========================================================
		// particle xml
		//========================================================
		[Embed(source="./assets/money_particle/particle.pex", mimeType="application/octet-stream")]
		public static var MoneyParticleXML:Class;
		
	}
}