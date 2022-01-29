package com.illuzor.circles.ui {
	
	import com.illuzor.circles.events.TextButtonEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class TextButton extends Sprite {
		
		private var textField:TextField;
		private var textBounds:Rectangle;
		private var _text:String;
		
		public function TextButton(text:String, color:uint = 0xFFFFFF) {
			this._text = text;
			textField = new TextField(10, 10, _text, "play", 100, color);
			textField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			textField.batchable = true;
			addChild(textField);
			textBounds = textField.bounds;
			
			this.addEventListener(TouchEvent.TOUCH, onButtonClick);
		}
		
		private function onButtonClick(e:TouchEvent):void {
			if(stage){
				var globalTouch:Touch = e.getTouch(stage);
				switch (globalTouch.phase) {
					case TouchPhase.BEGAN:
						textField.scaleX = textField.scaleY = .9;
						textField.x = (textBounds.width - textField.width) / 2;
						textField.y = (textBounds.height - textField.height) / 2;
					break;
					case TouchPhase.ENDED:
						textField.scaleX = textField.scaleY = 1;
						textField.x = 0;
						textField.y = 0;
						var localPosition:Point = e.getTouch(this).getLocation(this);
						if (textBounds.contains(localPosition.x, localPosition.y)) {
							dispatchEvent(new TextButtonEvent(TextButtonEvent.TRIGGERED));
						}
					break;
				}
			}
		}
		
		public function get text():String {
			return _text;
		}
		
		override public function dispose():void {
			this.removeEventListener(TouchEvent.TOUCH, onButtonClick);
			textField.dispose();
			super.dispose();
		}
		
	}
}