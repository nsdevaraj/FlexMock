package assets.skins
{
	import spark.components.CheckBox;

	public interface IChoiceSkin
	{
		function get correctFeedback():CheckBox
		function set correctFeedback(value:CheckBox):void
	}
}