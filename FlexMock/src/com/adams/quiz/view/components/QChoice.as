package com.adams.quiz.view.components
{ 	
	import org.osflash.signals.natives.NativeSignal;
	
	import spark.components.RadioButtonGroup;

	public interface QChoice  
	{
		function get clicked():NativeSignal
		function set clicked(value:NativeSignal):void
		function get correctAnswer():Boolean
		function set correctAnswer(value:Boolean):void
		function set group(value:RadioButtonGroup):void
		function get group():RadioButtonGroup
		function get selected():Boolean
		function set selected(value:Boolean):void
		function get visible():Boolean
		function set visible(value:Boolean):void
		function get label():String
		function set label(value:String):void
	}
}