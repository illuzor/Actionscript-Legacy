package com.illuzor.otherside.graphics.ui {
	
	import com.illuzor.otherside.constants.FontType;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class TextButton extends ButtonBase {
		
		private var texture:Texture;
		private var text:String;
		
		public function TextButton(texture:Texture, text:String) {
			this.text = text;
			this.texture = texture;
			super();
		}
		
		override protected function addGraphics():void {
			var image:Image = new Image(texture);
			addChild(image);
			touchRect = image.bounds;
			
			pivotX = touchRect.width >> 1;
			pivotY = touchRect.height >> 1;
			
			var textContainer:Sprite = new Sprite();
			textContainer.touchable = false;
			addChild(textContainer);
			
			var textField:TextField = new TextField(10, 10, text, new TextFormat("press_font", 72, 0xFFFFFF));
			textField.batchable = true;
			textField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			textContainer.addChild(textField);
			
			textContainer.height = image.height * .55;
			textContainer.scaleX = textContainer.scaleY;
			textContainer.x = (image.width - textContainer.width) >> 1;
			textContainer.y = (image.height - textContainer.height) >> 1;
		}
		
	}
}