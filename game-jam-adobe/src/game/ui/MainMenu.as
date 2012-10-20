/**
*	
*/
package game.ui
{	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;

	/**
	*	
	*/
	public class MainMenu extends Sprite
	{
		public static const START_GAME:String = "StartGame";

		private var _startText:TextField;

		/**
		*	@constructor
		*/
		public function MainMenu():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}

		private function handleAddedToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			this.stage.addEventListener(TouchEvent.TOUCH, handleStageTouch)

			// set up our stuff
			_startText = new TextField(300, 100, "Click to Start!");
			addChild(_startText);

			
		}

		private function handleRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);	
			this.stage.removeEventListener(TouchEvent.TOUCH, handleStageTouch)

			if (_startText.parent) _startText.parent.removeChild(_startText);
		}	

		private function handleStageTouch(evt:TouchEvent):void
		{
			// don't really care, just let someone know that we want to start.
			dispatchEvent(new Event(MainMenu.START_GAME));
		}
	}
}