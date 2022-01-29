package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.events.ControlManagerEvent;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class ControlManager extends EventDispatcher {
		
		private var stage:Stage;
		private var halfStageWidth:uint;
		private var keyPressed:Boolean;
		
		public function ControlManager() {
			halfStageWidth = ResizeManager.stageWidth >> 1;
			stage = Starling.current.stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyEvent);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void {
			var touches:Vector.<Touch> = e.getTouches(stage);
			if (touches.length) {
				var lastTouch:Touch = touches[touches.length - 1];
				if (touches.length == 1) {
					if(lastTouch.phase == TouchPhase.BEGAN){
						if (lastTouch.getLocation(stage).x <= halfStageWidth) {
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.LEFT));
						} else {
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.RIGHT));
						}
					} else if (lastTouch.phase == TouchPhase.ENDED) {
						dispatchEvent(new ControlManagerEvent(ControlManagerEvent.STOP));
					}
					
				} else {
					if(lastTouch.phase == TouchPhase.BEGAN){
						if (lastTouch.getLocation(stage).x <= halfStageWidth) {
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.LEFT));
						} else {
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.RIGHT));
						}
					}
				}
			}
		}
		
		private function onKeyEvent(e:KeyboardEvent):void {
			if (e.type == KeyboardEvent.KEY_DOWN) {
				if (!keyPressed) {
					keyPressed = true;
					switch (e.keyCode) {
						case Keyboard.A: 
						case Keyboard.LEFT: 
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.LEFT));
							break;
						case Keyboard.RIGHT: 
						case Keyboard.D: 
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.RIGHT));
							break;
					}
				}
			} else {
				keyPressed = false;
				dispatchEvent(new ControlManagerEvent(ControlManagerEvent.STOP));
			}
		}
		
		public function dispose():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyEvent);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyEvent);
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			stage = null;
		}
		
	}
}