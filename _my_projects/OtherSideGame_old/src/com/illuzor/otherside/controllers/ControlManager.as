package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.events.ControlManagerEvent;
	import com.illuzor.otherside.graphics.characters.ShipBase;
	import com.illuzor.otherside.tools.ResizeManager;
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
		
		private var ship:ShipBase;
		private var stage:Stage;
		private var stageWidth:uint;
		private var stageHeight:uint;
		private var halfWidth:uint;
		private var keyPressed:Boolean;
		
		public function ControlManager(ship:ShipBase) {
			this.ship = ship;
			stage = ResizeManager.stage;
			stageWidth = ResizeManager.stageWidth;
			stageHeight = ResizeManager.stageHeight;
			halfWidth = stageWidth >> 1;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onScreenTap);
			stage.addEventListener(MouseEvent.MOUSE_UP, onScreenTap);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyEvent);
		}
		
		private function onKeyEvent(e:KeyboardEvent):void {
			if (e.type == KeyboardEvent.KEY_DOWN) {
				if (!keyPressed) {
					keyPressed = true;
					switch (e.keyCode) {
						case Keyboard.LEFT:
						case Keyboard.A:
							//player.state = PlayerShip.LEFT;
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.MOVE_PLAYER, -ship.speed));
						break;
						case Keyboard.RIGHT:
						case Keyboard.D:
							//player.state = PlayerShip.RIGHT;
							dispatchEvent(new ControlManagerEvent(ControlManagerEvent.MOVE_PLAYER, ship.speed));
						break;
					}
				}
			} else {
				keyPressed = false;
				//player.state = PlayerShip.CENTER;
				dispatchEvent(new ControlManagerEvent(ControlManagerEvent.MOVE_PLAYER, 0));
			}
		}
		
		private function onScreenTap(e:MouseEvent):void { // TODO докрутить тач управление
			if (e.type == MouseEvent.MOUSE_DOWN) {
				if (e.localX <= halfWidth) {
					//player.state = PlayerShip.LEFT;
					dispatchEvent(new ControlManagerEvent(ControlManagerEvent.MOVE_PLAYER, -ship.speed));
				} else {
					//player.state = PlayerShip.RIGHT;
					dispatchEvent(new ControlManagerEvent(ControlManagerEvent.MOVE_PLAYER, ship.speed));
				}
			} else {
				//player.state = PlayerShip.CENTER;
				dispatchEvent(new ControlManagerEvent(ControlManagerEvent.MOVE_PLAYER, 0));
			}
		}
		
		public function dispose():void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onScreenTap);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onScreenTap);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyEvent);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyEvent);
		}
		
	}
}