/**
*	
*/
package game.utils
{	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	/**
	*	
	*/
	public class AssetLibrary
	{

		//========================================================
		// start screen
		//========================================================
		[Embed(source="./assets/screen_title.png")]
		private static var TitleSprite:Class;
		public static var titleSpriteBmp:Bitmap = new TitleSprite();		
		public static var titleTexture:Texture = Texture.fromBitmap(titleSpriteBmp);
		
		//========================================================
		// end screen
		//========================================================
		[Embed(source="./assets/screen_gameover.png")]
		private static var EndSprite:Class;
		public static var endSpriteBmp:Bitmap = new EndSprite();		
		public static var endTexture:Texture = Texture.fromBitmap(endSpriteBmp);
		
		//========================================================
		// cloudtop texture
		//========================================================
		[Embed(source="./assets/bg/clouds.png")]
		private static var CloudSprite:Class;
		public static var cloudSpriteBmp:Bitmap = new CloudSprite();		
		public static var cloudTexture:Texture = Texture.fromBitmap(cloudSpriteBmp);
		
		//========================================================
		// rooftop texture
		//========================================================
		[Embed(source="./assets/bg/movingcloud.png")]
		private static var MovingCloudSprite:Class;
		public static var movingCloudSpriteBmp:Bitmap = new MovingCloudSprite();		
		public static var movingCloudTexture:Texture = Texture.fromBitmap(movingCloudSpriteBmp);
		
		//========================================================
		// rooftop texture
		//========================================================
		[Embed(source="./assets/bg/rooftop.png")]
		private static var RoofSprite:Class;
		public static var roofSpriteBmp:Bitmap = new RoofSprite();		
		public static var roofTexture:Texture = Texture.fromBitmap(roofSpriteBmp);
		
		//========================================================
		// city texture
		//========================================================
		[Embed(source="./assets/bg/city.png")]
		private static var CitySprite:Class;
		public static var citySpriteBmp:Bitmap = new CitySprite();		
		public static var cityTexture:Texture = Texture.fromBitmap(citySpriteBmp);
		
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
		// enemy2 texture
		//========================================================
		[Embed(source="./assets/enemy2.png")]
		private static var Enemy2Sprite:Class;
		public static var enemy2SpriteBmp:Bitmap = new Enemy2Sprite();		
		public static var enemy2TextureIdle:Texture = Texture.fromBitmap(enemy2SpriteBmp);

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
		// bullet texture
		//========================================================
		[Embed(source="./assets/bullet_particle/texture.png")]
		public static var BulletParticleImage:Class;
		
		//========================================================
		// bullet xml
		//========================================================
		[Embed(source="./assets/bullet_particle/particle.pex", mimeType="application/octet-stream")]
		public static var BulletParticleXML:Class;
		
		
		//========================================================
		// placeholder powerup texture
		//========================================================
		[Embed(source="./assets/powerup.png")]
		public static var PlaceholderPowerup:Class;
		public static var placeholderPowerupBmp:Bitmap = new PlaceholderPowerup();		
		public static var placeholderPowerupTexture:Texture = Texture.fromBitmap(placeholderPowerupBmp);

		//========================================================
		// click through popup
		//========================================================
		[Embed(source="./assets/GUI_ClickThroughRate_still.png")]
		public static var GUI_ClickThroughRate_still:Class;
		public static var clickThroughpopup:Bitmap = new GUI_ClickThroughRate_still();		
		public static var clickThroughpopupTexture:Texture = Texture.fromBitmap(clickThroughpopup);

		//========================================================
		// metrics popup
		//========================================================
		[Embed(source="./assets/GUI_metrics_still.png")]
		public static var GUI_metrics_still:Class;
		public static var metricsPopup:Bitmap = new GUI_metrics_still();		
		public static var metricsPopupTexture:Texture = Texture.fromBitmap(metricsPopup);

		//========================================================
		// split testing popup
		//========================================================
		[Embed(source="./assets/GUI_SplitTesting_still.png")]
		public static var GUI_SplitTesting_still:Class;
		public static var splitTestBmp:Bitmap = new GUI_SplitTesting_still();		
		public static var splitTestBmpTexture:Texture = Texture.fromBitmap(splitTestBmp);

		//========================================================
		// dau popup
		//========================================================
		[Embed(source="./assets/GUI_DailyActiveUsers.png")]
		public static var GUI_DailyActiveUsers:Class;
		public static var dauPopup:Bitmap = new GUI_DailyActiveUsers();		
		public static var dauPopupTexture:Texture = Texture.fromBitmap(dauPopup);

		//========================================================
		// whale popup
		//========================================================
		[Embed(source="./assets/GUI_whale.png")]
		public static var GUI_whale:Class;
		public static var whalePopup:Bitmap = new GUI_whale();		
		public static var whalePopupTexture:Texture = Texture.fromBitmap(whalePopup);
		
		//========================================================
		// click through icon
		//========================================================
		[Embed(source="./assets/PowerUp_ClickThrough_still.png")]
		public static var PowerUp_ClickThrough_still:Class;
		public static var clickThroughIcon:Bitmap = new PowerUp_ClickThrough_still();		
		public static var clickThroughTexture:Texture = Texture.fromBitmap(clickThroughIcon);

		//========================================================
		// metrics icon
		//========================================================
		[Embed(source="./assets/PowerUp_metrics_still.png")]
		public static var PowerUp_metrics_still:Class;
		public static var metricsIcon:Bitmap = new PowerUp_metrics_still();		
		public static var metricsTexture:Texture = Texture.fromBitmap(metricsIcon);

		//========================================================
		// split testing icon
		//========================================================
		[Embed(source="./assets/PowerUp_SplitTesting_still.png")]
		public static var PowerUp_SplitTesting_still:Class;
		public static var splitIcon:Bitmap = new PowerUp_SplitTesting_still();		
		public static var splitTexture:Texture = Texture.fromBitmap(splitIcon);

		//========================================================
		// dau icon
		//========================================================
		[Embed(source="./assets/PowerUp_dailyActiveUsers_still.png")]
		public static var PowerUp_dailyActiveUsers_still:Class;
		public static var dauIcon:Bitmap = new PowerUp_dailyActiveUsers_still();		
		public static var dauTexture:Texture = Texture.fromBitmap(dauIcon);

		//========================================================
		// whale icon
		//========================================================
		[Embed(source="./assets/PowerUp_whale_still.png")]
		public static var PowerUp_whale_still:Class;
		public static var whaleIcon:Bitmap = new PowerUp_whale_still();		
		public static var whaleTexture:Texture = Texture.fromBitmap(whaleIcon);
		
		//========================================================
		// 
		//========================================================
		[Embed(source="./assets/audio/BG_loop.mp3")]
		public static var BGLoop:Class;
		
		[Embed(source="./assets/audio/You lose.mp3")]
		public static var PlayerHit:Class;
		
		[Embed(source="./assets/audio/LASER 1.mp3")]
		public static var PlayerShoot:Class;
		
		[Embed(source="./assets/audio/LASER 2.mp3")]
		public static var PlayerShoot2:Class;
		
		[Embed(source="./assets/audio/LASER 3.mp3")]
		public static var PlayerShoot3:Class;
		
		[Embed(source="./assets/audio/LASER 4.mp3")]
		public static var PlayerShoot4:Class;
		
		[Embed(source="./assets/audio/Start Sound.mp3")]
		public static var GameStart:Class;
		
		[Embed(source="./assets/audio/Powerup1.mp3")]
		public static var Powerup1:Class;
		
		[Embed(source="./assets/audio/Powerup2.mp3")]
		public static var Powerup2:Class;
		
		[Embed(source="./assets/audio/Powerup3.mp3")]
		public static var Powerup3:Class;
		
		[Embed(source="./assets/audio/Powerup4.mp3")]
		public static var Powerup4:Class;
	}
}