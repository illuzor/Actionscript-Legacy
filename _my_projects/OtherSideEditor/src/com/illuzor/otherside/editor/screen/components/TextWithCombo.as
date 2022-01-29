package com.illuzor.otherside.editor.screen.components {
	
	import com.bit101.components.ComboBox;
	import com.bit101.components.WheelMenu;
	import com.illuzor.otherside.editor.events.ComponentEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class TextWithCombo extends ComponentBase {
		private var combobox:Combobox;

		public function TextWithCombo(eventType:uint, w:uint, text:String, values:Array) {
			super(eventType, w, text);
			combobox = new Combobox(values, w - label.width - 4);
			combobox.x = label.width + 2;
			combobox.y = 1;
			addChild(combobox);
			combobox.addEventListener(Event.CHANGE, onChange);
		}
		
		public function setValue(value:String):void {
			combobox.setValue(value);
		}
		
		private function onChange(e:Event):void {
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE_VALUE, { type:eventType, value:combobox.currentValue } ));
		}
		
		override public function dispose():void {
			removeChildren();
			combobox.removeEventListener(Event.CHANGE, onChange);
		}
		
	}
}