package assets.skins
{
	import spark.skins.mobile.ButtonSkin;
	
	public class MButtonSkin extends ButtonSkin
	{ 
		private static const CHROME_COLOR_RATIOS:Array = [0, 127.5];
		
		private static const CHROME_COLOR_ALPHAS:Array = [1, 1];
		
		public function MButtonSkin()
		{
			super();
		}
		/*
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			
			var chromeColor:uint = getStyle("chromeColor");
			
			graphics.beginFill(chromeColor);
			var colors:Array = [];
			var colorMatrix:Matrix = new Matrix();
			colorMatrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);
			colors[0] = ColorUtil.adjustBrightness2(chromeColor, 70);
			colors[1] = chromeColor;
			
			graphics.beginGradientFill(GradientType.LINEAR, colors, CHROME_COLOR_ALPHAS, CHROME_COLOR_RATIOS, colorMatrix);
			// inset chrome color by BORDER_SIZE
			// bottom line is a shadow
			graphics.drawRect(layoutBorderSize, layoutBorderSize, 
				unscaledWidth - (layoutBorderSize * 2), 
				unscaledHeight - (layoutBorderSize * 2));
			graphics.endFill();
		}*/
	}
}