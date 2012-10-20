/**
*	
*/
package game.ui
{	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	*	
	*/
	public class Hud extends Sprite
	{
		private var _score:TextField;

		/**
		*	@constructor
		*/
		public function Hud():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}

		private function handleAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);

			// set up our stuff
			_score = new TextField(300, 100, "Score: 0");
			addChild(_score);
		}

		private function handleRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);	

			if (_score.parent) _score.parent.removeChild(_score);
		}

		public function setScore(value:int):void
		{
			_score.text = "Score: " + value;
		}
	}
}