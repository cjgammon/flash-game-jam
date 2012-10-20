package game.entities
{
	public class Background
	{
		import game.utils.AssetLibrary;
		import starling.textures.TextureSmoothing;
		import starling.textures.Texture;
		import starling.display.Image;

		private var _ground:Image;
		
		public function Background()
		{
			_ground = new Image(AssetLibrary.roofTexture);
			_ground.smoothing = TextureSmoothing.NONE;
			_sprite.addChild(_ground);
		}
	}
}