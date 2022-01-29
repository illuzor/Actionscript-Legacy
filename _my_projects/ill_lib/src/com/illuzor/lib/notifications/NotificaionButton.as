package com.illuzor.lib.notifications {

	import com.illuzor.common.TextArea;
	import com.illuzor.lib.notifications.NotificaionButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class NotificaionButton extends Sprite {
		
		private var buttonWidth:uint;
		private var buttonArea:Sprite;
		
		public function NotificaionButton(text:String) {
			
			this.buttonMode = true;
			
			var textArea:TextArea = new TextArea();
			textArea.textColor = 0x0;
			textArea.mouseEnabled = false;
			textArea.text = text;
			textArea.width = textArea.textWidth+4;
			textArea.height = textArea.textHeight+4;
			
			buttonArea = new Sprite();
			addChild(buttonArea);
			if (textArea.width <= 72) {
				buttonWidth = 82;
			} else {
				buttonWidth = textArea.width + 10;
			}
			redraw(0xD1D1D1);
			textArea.x = (buttonWidth - textArea.width) / 2;
			addChild(textArea);
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		private function onOver(e:MouseEvent):void {
			redraw(0xADE1F5);
		}
		
		private function onOut(e:MouseEvent):void {
			redraw(0xD1D1D1);
		}
		
		private function redraw(color:uint):void {
			buttonArea.graphics.clear();
			buttonArea.graphics.beginFill(color);
			buttonArea.graphics.drawRect(0, 0, buttonWidth, 22);
			buttonArea.graphics.endFill();
		}
		
	}

}