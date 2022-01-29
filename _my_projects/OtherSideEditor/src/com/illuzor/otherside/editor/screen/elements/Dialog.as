package com.illuzor.otherside.editor.screen.elements {
	
	import com.bit101.components.Label;
	import com.illuzor.framework.display.FastRect;
	import com.illuzor.otherside.editor.tools.GlobalResizer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Dialog extends Sprite {
		
		private var buttons:Vector.<Object>;
		
		public function Dialog(dialogText:String, buttons:Vector.<Object>, buttonsInLine:uint = 0) {
			this.buttons = buttons;
			var stageWidth:uint = GlobalResizer.stageWidth;
			var stageHeight:uint = GlobalResizer.stageHeight;
			var background:FastRect = new FastRect(stageWidth, stageHeight, 0x0, .7);
			addChild(background);
			
			var buttonsForLine:uint = 1024;
			if (buttonsInLine != 0) buttonsForLine = buttonsInLine;
			
			var infoContainer:Sprite = new Sprite();
			addChild(infoContainer);
			
			var label:Label = new Label(infoContainer, 0, 5, dialogText);
			label.textField.textColor = 0x0;
			
			var buttonsContainer:Sprite = new Sprite();
			if (label) buttonsContainer.y = label.y + label.height + 10;
			infoContainer.addChild(buttonsContainer);
			
			var yCounter:uint = 0;
			var xCounter:uint = 0;
			
			for (var i:int = 0; i < buttons.length; i++) {
				buttons[i].button.addEventListener(MouseEvent.CLICK, buttons[i].func);
				buttonsContainer.addChild(buttons[i].button);
				if (i != 0) buttons[i].button.x = xCounter * 120;
				buttons[i].button.y = yCounter * 30;
				if (xCounter < buttonsForLine-1) {
					xCounter++;
				} else {
					yCounter++;
					xCounter = 0;
				}
			}
			
			infoContainer.graphics.lineStyle(1, 0x2D2D2D);
			infoContainer.graphics.beginFill(0xD8D8D8);
			infoContainer.graphics.drawRect(0, 0, infoContainer.width + 40, infoContainer.height + 20);
			infoContainer.graphics.endFill();
			
			label.x = (infoContainer.width - label.width) >> 1;
			buttonsContainer.x = (infoContainer.width - buttonsContainer.width) >> 1;
			
			infoContainer.x = (stageWidth - infoContainer.width) >> 1;
			infoContainer.y = (stageHeight - infoContainer.height) >> 1;
		}
		
		public function dispose():void {
			for (var i:int = 0; i < buttons.length; i++) {
				buttons[i].button.removeEventListener(MouseEvent.CLICK, buttons[i].func);
			}
		}
		
	}
}