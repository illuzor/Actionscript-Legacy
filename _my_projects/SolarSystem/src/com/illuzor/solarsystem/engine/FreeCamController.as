package com.illuzor.solarsystem.engine {
	
	import away3d.controllers.HoverController;
	import away3d.entities.Entity;
	import away3d.containers.ObjectContainer3D;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class FreeCamController extends HoverController {
		
		private var stage:Stage;
		private var panIncrement:Number=0;
		private var tiltIncrement:Number=0;
		private var distanceIncrement:Number=0;
		private var tiltSpeed:Number = -1.5;
		private var panSpeed:Number = -1.5;
		private var distanceSpeed:Number = 5;
		
		private var lastX:Number;
		private var lastY:Number;
		private var startX:Number;
		
		public function FreeCamController(stage:Stage,targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000, minTiltAngle:Number = -90, maxTiltAngle:Number = 90, minPanAngle:Number = NaN, maxPanAngle:Number = NaN, steps:uint = 8, yFactor:Number = 2, wrapPanAngle:Boolean = false) {
			super(targetObject, lookAtObject, panAngle, tiltAngle, distance, minTiltAngle, maxTiltAngle, minPanAngle, maxPanAngle, steps, yFactor, wrapPanAngle);
			this.stage = stage;
			
			//this.minTiltAngle = -Infinity;
			//this.maxTiltAngle = Infinity;
			//this. = 
			
			iniListeners();
		}
		
		private function iniListeners():void {
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
			//stage.addEventListener(KeyboardEvent.KEY_UP, onKeyReleased);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel)
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			this.distance -= e.delta*distanceSpeed;
		}
		
		private function onMouseDown(e:MouseEvent):void {
			lastX = stage.mouseX;
			lastY = stage.mouseY;
			
			startX = stage.mouseX;
			
			stage.addEventListener(Event.ENTER_FRAME, mouseUpdate);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function mouseUpdate(e:Event):void {
			
			var currentX:Number = stage.mouseX;
			var currentY:Number = stage.mouseY;
			
			if (currentX < lastX || currentX > lastX) {
				panIncrement = panSpeed * calcDigit(lastX - currentX);
			} else {
				panIncrement = 0;
			}
			
			if (currentY < lastY || currentY > lastY) {
				tiltIncrement = tiltSpeed * calcDigit(lastY - currentY);
			} else {
				tiltIncrement = 0;
			}
			
			//panIncrement = startX + stage.mouseX;
			
			lastX = stage.mouseX;
			lastY = stage.mouseY;
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(Event.ENTER_FRAME, mouseUpdate);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			panIncrement = 0;
			tiltIncrement = 0;
		}
		
		/*private function onKeyPressed(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.UP:
				case Keyboard.W:
					tiltIncrement = tiltSpeed;
					break;
				case Keyboard.DOWN:
				case Keyboard.S:
					tiltIncrement = -tiltSpeed;
					break;
				case Keyboard.LEFT:
				case Keyboard.A:
					panIncrement = +panSpeed;
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					panIncrement = -panSpeed;
					break;
				case Keyboard.Z:
					distanceIncrement = distanceSpeed;
					break;
				case Keyboard.X:
					distanceIncrement = -distanceSpeed;
					break;
			}
		}
		
		private function onKeyReleased(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.UP:
				case Keyboard.W:
				case Keyboard.DOWN:
				case Keyboard.S:
					tiltIncrement = 0;
					break;
				case Keyboard.LEFT:
				case Keyboard.A:
				case Keyboard.RIGHT:
				case Keyboard.D:
					panIncrement = 0;
					break;
				case Keyboard.Z:
				case Keyboard.X:
					distanceIncrement = 0;
					break;
			}
		}*/
		
		private function calcDigit(num:Number):int {
			if (num < 0) {
				return -1;
			} else if (num > 0) {
				return 1
			} else {
				return 0;
			}
		}
		
		public function updateMove():void {
			this.panAngle += panIncrement;
			this.tiltAngle += tiltIncrement;
			this.distance += distanceIncrement;

		}
		
	}
}