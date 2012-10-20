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
		// rooftop texture
		//========================================================
		[Embed(source="./assets/bg/rooftop.png")]
		private static var RoofSprite:Class;
		public static var roofSpriteBmp:Bitmap = new RoofSprite();		
		public static var roofTexture:Texture = Texture.fromBitmap(roofSpriteBmp);
		
		//========================================================
		// scenery texture
		//========================================================
		[Embed(source="./assets/bg/scenery.png")]
		private static var ScenerySprite:Class;
		public static var scenerySpriteBmp:Bitmap = new ScenerySprite();		
		public static var sceneryTexture:Texture = Texture.fromBitmap(scenerySpriteBmp);
		
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
		// bullet texture
		//========================================================
		[Embed(source="./assets/bullet.png")]
		private static var BulletSprite:Class;
		public static var bulletSpriteBmp:Bitmap = new BulletSprite();		
		public static var bulletTexture:Texture = Texture.fromBitmap(bulletSpriteBmp);
		
		//========================================================
		// coin texture
		//========================================================
		[Embed(source="./assets/money_particle/change.png")]
		public static var CoinParticleTexture:Class;
		
		//========================================================
		// coin texture2
		//========================================================
		[Embed(source="./assets/money_particle/change2.png")]
		public static var Coin2ParticleTexture:Class;
		
		//========================================================
		// coin xml
		//========================================================
		[Embed(source="./assets/money_particle/coin.pex", mimeType="application/octet-stream")]
		public static var CoinParticleXML:Class;
		
		//========================================================
		// dollar texture
		//========================================================
		[Embed(source="./assets/money_particle/texture.png")]
		public static var MoneyParticleTexture:Class;
		
		//========================================================
		// particle xml
		//========================================================
		[Embed(source="./assets/money_particle/particle.pex", mimeType="application/octet-stream")]
		public static var MoneyParticleXML:Class;
		
		//========================================================
		// placeholder powerup texture
		//========================================================
		[Embed(source="./assets/powerup.png")]
		public static var PlaceholderPowerup:Class;
		public static var placeholderPowerupBmp:Bitmap = new PlaceholderPowerup();		
		public static var placeholderPowerupTexture:Texture = Texture.fromBitmap(placeholderPowerupBmp);

		//========================================================
		// 
		//========================================================
		[Embed(source="./assets/audio/BG_loop.mp3")]
		public static var BGLoop:Class;
	}
}