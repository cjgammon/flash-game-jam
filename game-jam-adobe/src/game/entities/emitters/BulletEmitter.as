package game.entities.emitters
{
	public class BulletEmitter
	{
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		
		import game.utils.AssetLibrary;
		
		import starling.core.Starling;
		import starling.display.Sprite;
		import starling.extensions.PDParticleSystem;
		import starling.textures.Texture;
		
		
		public var emitter:PDParticleSystem;
		
		public function BulletEmitter()
		{
			_sprite = new Sprite();
			
			emitter = new PDParticleSystem(XML(new AssetLibrary.BulletParticleXML()), Texture.fromBitmap(new AssetLibrary.BulletParticleImage()));
			Starling.juggler.add(emitter);
			_sprite.addChild(emitter);
		}
		
		public function set angle(newAngle:Number):void
		{
			emitter.emitAngle = newAngle;
		}
		
		public function start():void
		{
			emitter.start();
			
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER, handle_TIMER);
			timer.start();
		}
		
		public function stop():void{
			emitter.stop();
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