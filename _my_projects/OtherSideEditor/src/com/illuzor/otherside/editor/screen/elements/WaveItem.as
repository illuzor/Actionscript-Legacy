package com.illuzor.otherside.editor.screen.elements {
	
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.illuzor.otherside.editor.events.WaveItemEvent;
	import com.illuzor.otherside.editor.tools.Assets;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 
	 * @author illuzor  //  illuzor.com
	 */
	
	public class WaveItem extends Sprite {
		
		public var data:Object = { };
		private var waveType:String;
		private var itemWidth:uint;
		private var upButton:PushButton;
		private var downButton:PushButton;
		private var deleteButton:PushButton;
		private var backgroundButton:Sprite;
		private var id:uint;
		private var _selected:Boolean;
		
		public function WaveItem(waveType:String, itemWidth:uint, id:uint) {
			this.id = id;
			this.itemWidth = itemWidth;
			this.waveType = waveType;
			data.type = waveType;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			backgroundButton = new Sprite();
			addChild(backgroundButton);
			drawBackground(0x98CBCB);

			var icon:Sprite = Assets.mainAtlas.getSprite("icon_" + waveType);
			icon.mouseChildren = false;
			icon.mouseEnabled = false;
			icon.graphics.beginFill(0x0, .8);
			icon.graphics.drawRoundRect(0, 0, icon.width, icon.height, 3);
			icon.x = 2;
			icon.y = (26 - icon.height) >> 1;
			addChild(icon);
			
			upButton = new PushButton(this, 30, 3, "UP");
			upButton.width = 36;
			downButton = new PushButton(this, upButton.x + upButton.width + 6, 3, "DOWN");
			downButton.width = 36;
			
			deleteButton = new PushButton(this, downButton.x + downButton.width + 6, 3, "DEL");
			deleteButton.width = 36;
			deleteButton.labelItem.textField.textColor = 0xCA0000;
			
			var idLabel:Label = new Label(this, deleteButton.x + deleteButton.width + 6, 3, "id:" + String(id));
			
			upButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			downButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			deleteButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			backgroundButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}

		private function onButtonClick(e:MouseEvent):void {
			var eventType:String
			switch (e.currentTarget) {
				case upButton:
					eventType = WaveItemEvent.UP;
				break;
				case downButton:
					eventType = WaveItemEvent.DOWN;
				break;
				case deleteButton:
					eventType = WaveItemEvent.DELETE;
				break;
				case backgroundButton:
					eventType = WaveItemEvent.SELECT;
					drawBackground(0x00AA00);
				break;
			}
			dispatchEvent(new WaveItemEvent(eventType));
		}
		
		public function deselect():void {
			drawBackground(0x98CBCB);
		}
		
		[Inline]
		private final function drawBackground(color:uint):void {
			backgroundButton.graphics.clear();
			backgroundButton.graphics.lineStyle(1, 0x0, .3);
			backgroundButton.graphics.beginFill(color, .4);
			backgroundButton.graphics.drawRect(0, 0, itemWidth, 26);
			backgroundButton.graphics.endFill();
		}
		
		private function onRemoved(e:Event):void {
			removeChildren();
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			upButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			downButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			deleteButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function get type():String {
			return waveType;
		}
		
	}
}