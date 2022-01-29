package com.illuzor.otherside.editor.screen.components {
	import com.bit101.components.CheckBox;
	import com.illuzor.otherside.editor.events.ComponentEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class CheckText extends ComponentBase {
		private var checkbox:CheckBox;
		
		public function CheckText(eventType:uint, w:uint, text:String) {
			super(eventType, w, "");
			
			checkbox = new CheckBox(this);
			checkbox.label = text;
			checkbox.x = 5;
			checkbox.y = 5;
			checkbox.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE_VALUE, { type:eventType, value:checkbox.selected } ));
		}
		
		override public function dispose():void {
			checkbox.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
	}
}