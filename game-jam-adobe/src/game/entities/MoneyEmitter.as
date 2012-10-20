package game.entities
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.utils.AssetLibrary;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.extensions.ParticleDesignerPS;
	import starling.textures.Texture;

	/**
	 *	contians money particle emitters
	 */
	public class MoneyEmitter
	{
		private var money:ParticleDesignerPS;
		private var money2:ParticleDesignerPS;
		private var money3:ParticleDesignerPS;
		
		/**
		 *	@constructor
		 */
		public function MoneyEmitter()
		{
			_sprite = new Sprite();
			
			money = new ParticleDesignerPS(XML(new AssetLibrary.MoneyParticleXML()), Texture.fromBitmap(new AssetLibrary.MoneyParticleTexture()));
			Starling.juggler.add(money);
			_sprite.addChild(money);
			
			money2 = new ParticleDesignerPS(XML(new AssetLibrary.CoinParticleXML()), Texture.fromBitmap(new AssetLibrary.CoinParticleTexture()));
			Starling.juggler.add(money2);
			_sprite.addChild(money2);
			
			money3 = new ParticleDesignerPS(XML(new AssetLibrary.CoinParticleXML()), Texture.fromBitmap(new AssetLibrary.Coin2ParticleTexture()));
			Starling.juggler.add(money3);
			_sprite.addChild(money3);			
		}
		
		/*
		* start emitting
		*/
		public function start():void
		{
			money.start();			
			money2.start();			
			money3.start();
			
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, handle_TIMER);
			timer.start();
		}
		
		public function stop():void{
			money.stop();			
			money2.stop();			
			money3.stop();				
		}
		
		private function handle_TIMER(e:TimerEvent):void
		{
			stop();
		}
		
		/**
		 * _sprite is the entire sprite, so like the dood, and any UI shit we may stick on him.
		 */
		protected var _sprite:Sprite;
		public function get sprite():Sprite { return _sprite; }
	}
}