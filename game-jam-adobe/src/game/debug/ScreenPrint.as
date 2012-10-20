package game.debug
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import game.data.GlobalData;
	
	
	public class ScreenPrint extends Object
	{
		public static const ALIGN_NONE:int 				= 0;
		public static const ALIGN_UPPER_LEFT:int 		= 1;
		public static const ALIGN_LOWER_LEFT:int 		= 2;
		public static const ALIGN_UPPER_RIGHT:int 		= 3;
		public static const ALIGN_LOWER_RIGHT:int 		= 4;
		public static const ALIGN_MODE_TOTAL:int 		= 5;
		
		public static var prints:Array = new Array();
		public static var textfields:Array = new Array();
		public static var parent:Sprite;
		public static var printContainer:Sprite;
		
		public static var render:Boolean = true;
		public static var alignment:int = ALIGN_LOWER_RIGHT;
		
		public static function init(parent:Sprite):void
		{
			ScreenPrint.parent = parent;
			if (!ScreenPrint.parent) throw(new Error("ScreenPrint must be assigned a parent!"))
			printContainer = new Sprite();
			parent.addChild(printContainer);
			updateAlignment();
		}
		
		public static function nextAlignment():void
		{
			alignment++;
			if (alignment == ALIGN_MODE_TOTAL) alignment = 0;
			updateAlignment();
		}
		
		public static function updateAlignment():void
		{
			//trace("ScreenPrint::nextAlignment() -> " + alignment);
			printContainer.visible = true;
			switch(alignment)
			{
				case ALIGN_NONE :
					printContainer.visible = false;
				break;
				case ALIGN_UPPER_LEFT :
					printContainer.x = printContainer.y = 0;
				break;
				case ALIGN_LOWER_LEFT :
					printContainer.x = 0;
					printContainer.y = ScreenPrint.parent.stage.stageHeight;
				break;
				case ALIGN_UPPER_RIGHT :
					printContainer.x = ScreenPrint.parent.stage.stageWidth;
					printContainer.y = 0;
				break;
				case ALIGN_LOWER_RIGHT :
					printContainer.x = ScreenPrint.parent.stage.stageWidth;
					printContainer.y = ScreenPrint.parent.stage.stageHeight;
				break;
			}
			//trace( "printContainer.x::" + printContainer.x );
			//trace( "printContainer.y::" + printContainer.y );
		}
		
		/**
		* 
		* @param page which page of screenprints you want this print to appear on.
		*/
		public static function show(message:String):void
		{
			if (render && GlobalData.DEBUG) 
			{
				ScreenPrint.prints.push(message);
			}
		}
		

		
		public static function update():void
		{
			// clean up textfields
			var tf:TextField;
			//trace( "ScreenPrint.textfields.length::" + ScreenPrint.textfields.length );
			for (var j:int = 0; j < ScreenPrint.textfields.length; j++)
			{
				tf = ScreenPrint.textfields[j];
				printContainer.removeChild(tf);
				ScreenPrint.textfields.splice(j, 1);
			}
			
			var printsToUse:Array = prints;
			for (var i:int = 0; i < printsToUse.length; i++)
			{
				tf = new TextField();
				tf.height = 17;
				tf.textColor = 0xffffff;
				tf.background = true;
				tf.backgroundColor = 0x000000;
				tf.text = printsToUse[i];
				tf.autoSize = "left";
				
				switch(alignment)
				{
					case ALIGN_UPPER_LEFT :
						tf.x = 0;
						tf.y = (i * tf.height);
					break;
					case ALIGN_LOWER_LEFT :
						tf.x = 0;
						tf.y = ((i * tf.height) - (printsToUse.length * tf.height));
					break;
					case ALIGN_UPPER_RIGHT :
						tf.x = -tf.width
						tf.y = (i * tf.height);
					break;
					case ALIGN_LOWER_RIGHT :
						tf.x = -tf.width
						tf.y = ((i * tf.height) - (printsToUse.length * tf.height))
					break;
				}
				
				printContainer.addChild(tf);
				ScreenPrint.textfields.push(tf);
				
			}
			
			// wipe ALL prints (all modes too) for next time.
			ScreenPrint.prints = new Array();
		}
	}
}