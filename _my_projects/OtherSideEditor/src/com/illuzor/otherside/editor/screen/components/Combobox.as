package com.illuzor.otherside.editor.screen.components {
	
	import com.bit101.components.Label;
	import com.illuzor.framework.display.FastRect;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Combobox extends Sprite {
		
		private var label:Label;
		private var values:Array;
		private var comboWidth:uint;
		private var buttonsContainer:Sprite;
		
		public function Combobox(values:Array, comboWidth:uint) {
			this.comboWidth = comboWidth;
			this.values = values;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			buttonsContainer = new Sprite();
			addChild(buttonsContainer);
			buttonsContainer.y = 18;
			buttonsContainer.visible = false;
			for (var i:int = 0; i < values.length; i++) {
				var button:Sprite = makeButton(values[i], comboWidth);
				if(i!=0)button.y = buttonsContainer.height - 1;
				buttonsContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
			
			label = new Label(this, 10, 1);
			setValue(values[0]);
			
			var invSprite:Sprite = new Sprite();
			invSprite.buttonMode = true;
			addChild(invSprite);
			invSprite.addChild(new FastRect(comboWidth, 18, 0x0, 0));
			
			invSprite.addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}

		private function onButtonClick(e:MouseEvent):void {
			buttonsContainer.visible = false;
			stage.removeEventListener(MouseEvent.CLICK, onStageClick);
			setValue(e.currentTarget.name);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onClick(e:MouseEvent):void {
			if (!buttonsContainer.visible) {
				buttonsContainer.visible = true;
				stage.addEventListener(MouseEvent.CLICK, onStageClick);
			} else {
				buttonsContainer.visible = false;
				stage.removeEventListener(MouseEvent.CLICK, onStageClick);
			}
		}
		
		private function onStageClick(e:MouseEvent):void {
			if (mouseX < 0 || mouseX > this.width || mouseY < 0 || mouseY > this.height) {
				stage.removeEventListener(MouseEvent.CLICK, onStageClick);
				buttonsContainer.visible = false;
			}  
		}
		
		private function makeButton(butText:String, butWidth:uint):Sprite {
			var button:Sprite = new Sprite();
			button.name = butText;
			button.graphics.beginFill(0xF7F7F7);
			button.graphics.drawRect(0, 0, butWidth, 18);
			button.graphics.endFill();
			var label:Label = new Label(button, 3, 2, butText);
			return button;
		}
		
		public function setValue(value:String):void {
			label.text = value;
		}
		
		public function get currentValue():String {
			return label.text;
		}
		
		private function onRemoved(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			stage.removeEventListener(MouseEvent.CLICK, onStageClick);
			for (var i:int = 0; i < buttonsContainer.numChildren; i++) {
				(buttonsContainer.getChildAt(i) as Sprite).removeEventListener(MouseEvent.CLICK, onButtonClick);
			}
		}
		
	}
}