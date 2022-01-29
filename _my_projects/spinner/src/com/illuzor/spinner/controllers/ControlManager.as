package com.illuzor.spinner.controllers {
	
	import com.illuzor.spinner.events.ControlManagerEvent;
	import com.illuzor.spinner.tools.ResizeManager;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ControlManager extends EventDispatcher{
		
		private var stage:Stage;
		private var halfWidht:uint;
		private var keyPressed:Boolean;
		
		public function ControlManager() {
			stage = ResizeManager.stage;
			ResizeManager.addResize(resize);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKey);
		}
		
		private function onKey(e:KeyboardEvent):void {
			if (e.type == KeyboardEvent.KEY_DOWN) {
				if(!keyPressed){
					keyPressed = true;
					if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A) {
						dispatchEvent(new ControlManagerEvent(ControlManagerEvent.ROTATE_CCW));
					} else if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D) {
						dispatchEvent(new ControlManagerEvent(ControlManagerEvent.ROTATE_CW));
					}
				}
			} else {
				keyPressed = false;
			}
		}
		
		private function resize(stageWidth:uint, stageHeight:uint):void {
			halfWidht = stageWidth >> 1;
		}
		
		private function onTouch(e:MouseEvent):void {
			if (stage.mouseX <= halfWidht) {
				dispatchEvent(new ControlManagerEvent(ControlManagerEvent.ROTATE_CCW));
			} else {
				dispatchEvent(new ControlManagerEvent(ControlManagerEvent.ROTATE_CW));
			}
		}
		
		public function dispose():void {
			ResizeManager.removeResize(resize);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKey);
			stage = null;
		}
		
	}
}