package game.entities
{
	public class Background
	{
		import game.utils.AssetLibrary;
		
		import starling.display.Image;
		import starling.display.Sprite;
		import starling.textures.Texture;
		import starling.textures.TextureSmoothing;

		private var _groundImage:Image;
		private var _sceneryImage:Image;
		private var _cityImage:Image;
		private var _cloudImage:Image;
		private var _movingCloudImage:Image;

		private var _clouds:Array = [];
		
		public var sprite:Sprite;

		public function Background()
		{
			sprite = new Sprite();
			
			_sceneryImage = new Image(AssetLibrary.sceneryTexture);
			_sceneryImage.smoothing = TextureSmoothing.NONE;
			_sceneryImage.x = 0;
			_sceneryImage.y = 0;
			sprite.addChild(_sceneryImage);
			
			_cloudImage = new Image(AssetLibrary.cloudTexture);
			_cloudImage.smoothing = TextureSmoothing.NONE;
			_cloudImage.x = 0;
			_cloudImage.y = 0;
			sprite.addChild(_cloudImage);
			
			_cityImage = new Image(AssetLibrary.cityTexture);
			_cityImage.smoothing = TextureSmoothing.NONE;
			_cityImage.x = 0;
			_cityImage.y = 45;
			sprite.addChild(_cityImage);
			
			_groundImage = new Image(AssetLibrary.roofTexture);
			_groundImage.smoothing = TextureSmoothing.NONE;
			_groundImage.x = 0;
			_groundImage.y = 85;
			sprite.addChild(_groundImage);
		}
	}
}