package com.illuzor.engine3d.ui {
	
	import com.illuzor.engine3d.graphics.ButtonDesign;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * Класс кнопки
	 * 
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public dynamic class Button extends Sprite {
		
		private var text:String;
		private var forcedWidth:uint;
		private var button:ButtonDesign;
		
		public function Button(text:String, forcedWidth:uint = 0) {
			this.forcedWidth = forcedWidth;
			this.text = text;
			
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			button = new ButtonDesign();
			button.tf.text = text;
			
			if (forcedWidth == 0) {
				button.tf.width = button.tf.textWidth + 10;
				button.background.width = button.tf.width + 10;
			} else {
				button.background.width = forcedWidth;
				button.tf.width = forcedWidth - 10;
			}
			button.inv.width = button.background.width;
			
			button.inv.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.inv.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addChild(button);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}

		private function onOver(e:MouseEvent):void {
			button.tf.filters = [new GlowFilter(0x405ffb, 0.6, 4, 4)];
		}
		
		private function onOut(e:MouseEvent):void {
			button.tf.filters = null;
		}
		
		private function removed(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			button.inv.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.inv.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
	}
}