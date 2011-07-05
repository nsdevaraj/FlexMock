package assets.skins
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import spark.components.CheckBox;
	import spark.components.Label;
	import spark.skins.mobile.RadioButtonSkin;
	
	public class QRadioSkin extends RadioButtonSkin
	{
		public var correctFeedback:CheckBox;
		public function QRadioSkin()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,creationComplete,false,0,true);
		}
		protected function creationComplete(event:Event):void
		{
			
			correctFeedback = new CheckBox();
			correctFeedback.selected=true;
			correctFeedback.visible=false;
			correctFeedback.x = 350;
			this.addChild(correctFeedback);
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// super draws a transparent hit zone
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			// get the size and position of iconDisplay
			var currentIcon:DisplayObject = getIconDisplay();
			
			graphics.beginFill(000000,1);
			graphics.drawEllipse(currentIcon.x + 1, currentIcon.y + 1, currentIcon.width - 2, currentIcon.height - 2);
			graphics.endFill();
		}
		
	}
}