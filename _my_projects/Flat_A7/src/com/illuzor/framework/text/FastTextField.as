package com.illuzor.framework.text 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author iLLuzor  /// illuzor@illuzor.com
	 * FastTextField - класс для быстрого создания текстового поля всего несколькими параметрами.
	 */
	public class FastTextField extends TextField 
	{
		private var tf:TextFormat;
		
		public function FastTextField(tfText:String, tfWidth:uint, tfHeight:uint, textSize:uint, textColor:uint = 0x000000, textAlign:String = "left",  textFont:String = "Arial", embedFont:Boolean = false)
		{
			tf = new TextFormat();
			tf.font = textFont;
			tf.size = textSize;
			tf.color = textColor;
			if (textAlign == "left") {
				tf.align = TextFieldAutoSize.LEFT;
			} else if (textAlign == "right") {
				tf.align = TextFieldAutoSize.RIGHT;
			} else if (textAlign == "center") {
				tf.align = TextFieldAutoSize.CENTER;
			} else {
				tf.align = TextFieldAutoSize.NONE;
			}
			
			this.width = tfWidth;
			this.height = tfHeight;
			this.text = tfText;
			this.selectable = false;
			this.setTextFormat(tf);
			if (embedFont) this.embedFonts = true;
			this.defaultTextFormat = tf;
		}
		
	}

}