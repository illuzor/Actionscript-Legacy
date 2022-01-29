package com.illuzor.cats {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class MenuButton extends Sprite {
		
		private var _category:String;
		
		public function MenuButton(text:String, category:String) {
			_category = category;
			this.buttonMode = true;
			var texField:TextField = new TextField();
			texField.border = true;
			texField.mouseEnabled = false;
			texField.text = text;
			texField.autoSize = TextFieldAutoSize.LEFT;
			addChild(texField);
		}
		
		public function get category():String {
			return _category;
		}
		
	}
}