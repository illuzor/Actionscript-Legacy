package com.illuzor.thegame.editor.panels {
	
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.illuzor.thegame.editor.events.SelectLevelEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com  //  illuzor@gmail.com
	 */
	
	[Event(name="cancelSelection", type="com.illuzor.thegame.editor.events.SelectLevelEvent")]
	[Event(name = "levelSelected", type = "com.illuzor.thegame.editor.events.SelectLevelEvent")]
	
	public class SelectLevelPanel extends Sprite {
		
		private var _selectedLevel:uint;
		private var container:Sprite;
		private var cancelButton:PushButton;
		
		public function SelectLevelPanel(levels:Array) {
			container = new Sprite();
			addChild(container);
			
			var label:Label = new Label(this);
			label.text = "SELECT LEVEL TO EDIT";
			
			label.y = -30;
			
			for (var i:int = 0; i < levels.length ; i++) {
				var currentLevel:PushButton = new PushButton(container);
				if (i > 0) currentLevel.y = container.height +8;
				currentLevel.label = levels[i].name;
				currentLevel.addEventListener(MouseEvent.CLICK, onClick);
			}
			
			cancelButton = new PushButton(this);
			cancelButton.label = "CANCEL";
			cancelButton.y = container.y + container.height + 20;
			cancelButton.addEventListener(MouseEvent.CLICK, onCancel);
			
			if (levels.length == 0) {
				label.text = "NOTHING TO EDIT";
				cancelButton.label = "GO BACK";
			}
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onCancel(e:MouseEvent):void {
			dispatchEvent(new SelectLevelEvent(SelectLevelEvent.CANCEL));
		}
		
		private function onClick(e:MouseEvent):void {
			_selectedLevel = container.getChildIndex(e.currentTarget as PushButton);
			dispatchEvent(new SelectLevelEvent(SelectLevelEvent.LEVEL_SELECTED));
		}
		
		public function get selectedLevel():uint {
			return _selectedLevel;
		}
		
		private function onRemove(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			cancelButton.removeEventListener(MouseEvent.CLICK, onCancel);
			for (var i:int = 0; i <container.numChildren ; i++) {
				(container.getChildAt(i) as PushButton).removeEventListener(MouseEvent.CLICK, onClick);
			}
		}
		
	}
}