package com.illuzor.otherside.editor.screen.components {
	
	import com.bit101.components.CheckBox;
	import com.illuzor.otherside.editor.events.ComponentEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MultipleChoise extends ComponentBase {
		
		private var checkboxesContainer:Sprite;
		
		public function MultipleChoise(text:String, checkboxes:Vector.<String>, eventType:uint, w:uint = 200) {
			super(eventType, w, text);
			checkboxesContainer = new Sprite();
			checkboxesContainer.x = label.width + 3;
			checkboxesContainer.y = 4;
			addChild(checkboxesContainer);
			
			for (var i:int = 0; i < checkboxes.length; i++) {
				var checkbox:CheckBox = new CheckBox(this);
				checkbox.label = checkboxes[i];
				if (i != 0) checkbox.x = checkboxesContainer.width + 40;
				checkboxesContainer.addChild(checkbox);
				checkbox.addEventListener(MouseEvent.CLICK, onClick);
			}
		}
		
		private function onClick(e:MouseEvent):void {
			var vector:Vector.<Boolean> = new Vector.<Boolean>();
			for (var i:int = 0; i < checkboxesContainer.numChildren; i++) {
				vector.push((checkboxesContainer.getChildAt(i) as CheckBox).selected);
			}
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE_VALUE, { type:eventType, value:vector } ));
		}
		
		public function setValue(value:Vector.<Boolean>):void {
			for (var i:int = 0; i < checkboxesContainer.numChildren; i++) {
				(checkboxesContainer.getChildAt(i) as CheckBox).selected = value[i];
			}
		}
		
		override public function dispose():void {
			for (var i:int = 0; i < checkboxesContainer.numChildren; i++) {
				(checkboxesContainer.getChildAt(i) as CheckBox).removeEventListener(MouseEvent.CLICK, onClick);
			}
		}
		
	}
}