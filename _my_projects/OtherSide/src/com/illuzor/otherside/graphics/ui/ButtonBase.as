package com.illuzor.otherside.graphics.ui {
	
	import com.illuzor.otherside.errors.UIError;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class ButtonBase extends Sprite {
		
		protected var touchRect:Rectangle;
		private var touched:Boolean;
		
		public function ButtonBase() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addGraphics();
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		protected function addGraphics():void {
			throw new UIError("ButtonBase.addGraphics() method must be overrided");
		}
		
		private function onTouch(e:TouchEvent):void {
			var touch:Touch = e.getTouch(this);
			if (touch) {
				if (touch.phase == TouchPhase.BEGAN) {
					if (touchRect.contains(touch.getLocation(this).x, touch.getLocation(this).y)) {	
						touched = true;
						this.scale-= .1;
					}
				} else if (touch.phase == TouchPhase.ENDED) {
					if (touched) {
						if (touchRect.contains(touch.getLocation(this).x, touch.getLocation(this).y)) {	
							dispatchEvent(new Event(Event.TRIGGERED));
						}
						touched = false;
						this.scale+= .1;
					}
				}
			}
		}
		
		private function onRemoved(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
	}
}