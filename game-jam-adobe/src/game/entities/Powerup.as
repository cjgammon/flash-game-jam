/**
*	
*/
package game.entities
{	
	import com.greensock.TweenMax;
	import game.data.Player;
	import game.states.mainStates.GameplayState;
	import game.utils.AssetLibrary;
	import game.utils.GeomUtils;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureSmoothing;

	/**
	*	
	*/
	public class Powerup extends Entity
	{

		public static const TYPE_STREAM:String = "TYPE_STREAM";
		public static const TYPE_SPREAD:String = "TYPE_SPREAD";
		public static const TYPE_SPHERE:String = "TYPE_SPHERE";
		public static const TYPE_QUICKBULLET:String = "TYPE_QUICKBULLET";
		public static const TYPE_SILVERBULLET:String = "TYPE_SILVERBULLET";
		public static const TYPE_RUBBER_BULLET:String = "TYPE_RUBBER_BULLET";
		public static const TYPE_BULLET_DISTANCE:String = "TYPE_BULLET_DISTANCE";
		public static const TYPE_EXPLOSIVE:String = "TYPE_EXPLOSIVE";

		public static const TYPES:Array = 
		[
			//TYPE_STREAM,
			//TYPE_SPREAD,
			//TYPE_SPHERE,
			//TYPE_QUICKBULLET,
			//TYPE_SILVERBULLET,
			//TYPE_RUBBER_BULLET,// not hooked up yet
			//TYPE_BULLET_DISTANCE,// not hooked up yet
			TYPE_EXPLOSIVE
		];

		public static var typeGraphics:Object = {};
		public static function initGraphicRefs():void
		{
			for (var powerupIndex:int = 0; powerupIndex < Powerup.TYPES.length; powerupIndex++)
			{
				var type:String = Powerup.TYPES[powerupIndex];

				var popupSprite:Sprite = new Sprite();
				var popupImage:Image;
				var iconSprite:Sprite = new Sprite();
				var iconImage:Image;
				switch(type)
				{
					case Powerup.TYPE_STREAM: 			popupImage = new Image(AssetLibrary.clickThroughpopupTexture);	iconImage = new Image(AssetLibrary.clickThroughTexture);	break;
					case Powerup.TYPE_SPHERE: 			popupImage = new Image(AssetLibrary.metricsPopupTexture);		iconImage = new Image(AssetLibrary.metricsTexture);	break;
					case Powerup.TYPE_SPREAD: 			popupImage = new Image(AssetLibrary.splitTestBmpTexture);		iconImage = new Image(AssetLibrary.splitTexture);	break;
					case Powerup.TYPE_QUICKBULLET: 		popupImage = new Image(AssetLibrary.dauPopupTexture);		iconImage = new Image(AssetLibrary.dauTexture);	break;
					case Powerup.TYPE_SILVERBULLET: 	popupImage = new Image(AssetLibrary.whalePopupTexture);		iconImage = new Image(AssetLibrary.whaleTexture);	break;
					case Powerup.TYPE_EXPLOSIVE: 		popupImage = new Image(AssetLibrary.whalePopupTexture);		iconImage = new Image(AssetLibrary.whaleTexture);	break;
					case Powerup.TYPE_RUBBER_BULLET: 	popupImage = new Image(AssetLibrary.whalePopupTexture);		iconImage = new Image(AssetLibrary.whaleTexture);	break;
					case Powerup.TYPE_BULLET_DISTANCE: 	popupImage = new Image(AssetLibrary.whalePopupTexture);		iconImage = new Image(AssetLibrary.whaleTexture);	break;
				}
 
				if (popupImage && iconImage)
				{
					popupImage.x = 343/2;
					popupImage.y = 102/2;
					popupSprite.addChild(popupImage);
					iconImage.x = -11;
					iconImage.y = -16;
					iconSprite.addChild(iconImage);
					typeGraphics[type] = {popup:popupSprite, icon:iconSprite};
				}
			}
		}

		private var _id:String;
		public function get id():String { return _id; }
		public function set id(value:String):void
		{
			_id = value;
			var t:Object = typeGraphics[_id];
			if (t && t.icon)
			{
				_sprite.addChild(t.icon);
			}
			else
			{
				_bodyImage = new Image(AssetLibrary.placeholderPowerupTexture);
				_bodyImage.smoothing = TextureSmoothing.NONE;
				_sprite.addChild(_bodyImage);
			}

			switch(_id)
			{
				case Powerup.TYPE_SPREAD: 		
					rect.width = 32;
					rect.height = 22;
				break;
				default: 	
					rect.width = 22; 
					rect.height = 32	
				break;
			}
		}


		
		/**
		*	@constructor
		*/
		public function Powerup():void
		{
			super();

			rect.width = 22;
			rect.height = 32;

			// moved to set id()
			//_bodyImage = new Image(AssetLibrary.placeholderPowerupTexture);
			//_bodyImage.smoothing = TextureSmoothing.NONE;
			//_sprite.addChild(_bodyImage);
			_sprite.scaleX = 0.75;
			_sprite.scaleY = 0.75;
			TweenMax.to(_sprite, 0.2, {scaleX:0.9, scaleY:0.9, yoyo:true, repeat:-1});
		}
		
		override public function takeTurn():void
		{
			// if we're overlapping any heroes, have the hero pick me up.
			var touchingHeroes:Array = getTouchingPlayers();

			// just give it to the first hero.
			if (touchingHeroes.length > 0)
			{
				_gameState.acquirePowerup(touchingHeroes[0].avatar, this);
			}
		}
		
	}
}