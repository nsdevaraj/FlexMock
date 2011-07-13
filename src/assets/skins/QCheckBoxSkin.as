package assets.skins
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import spark.components.CheckBox;
	import spark.components.Label;
	import spark.skins.mobile.CheckBoxSkin;
	
	public class QCheckBoxSkin extends CheckBoxSkin implements IChoiceSkin 
	{
		private var _correctFeedback:CheckBox;
		public function QCheckBoxSkin()
		{
			super();
			layoutGap = 30;
			addEventListener(Event.ADDED_TO_STAGE,creationComplete,false,0,true);
		}

		public function get correctFeedback():CheckBox
		{
			return _correctFeedback;
		}

		public function set correctFeedback(value:CheckBox):void
		{
			_correctFeedback = value;
		}

		protected function creationComplete(event:Event):void
		{
			
			correctFeedback = new CheckBox();
			correctFeedback.selected=true;
			correctFeedback.visible=false;
			correctFeedback.x = 30;
			width = width+30;
			this.addChild(correctFeedback);
		} 
	}
}