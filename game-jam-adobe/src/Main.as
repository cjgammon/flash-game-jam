package
{
	import flash.display.Sprite;
	import game.debug.Stats;
	import starling.core.Starling;

	

	[SWF(width="400", height="300", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite
	{
		private var _starling:Starling;
		private var _stats:Stats = new Stats();

		public function Main()
		{
			_starling = new Starling(Game, stage);
			_starling.start();

			addChild(_stats);
		}
	}
}