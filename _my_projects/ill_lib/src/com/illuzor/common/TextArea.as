package com.illuzor.common {
	
	import flash.text.TextField;
	import flash.system.Security;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class TextArea extends TextField {
		
		public function TextArea() {
			
			if(!FontManager.registred)FontManager.register();
			
			var textFormat:TextFormat = new TextFormat("RobotoRegular");
			textFormat.size = 14;
			this.textColor = 0xFFFFFF;
			this.defaultTextFormat = textFormat;
			this.embedFonts = true;
			this.selectable = false;
		}
		
	}
}