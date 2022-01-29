package com.illuzor.leaptest.away3d.tools {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Entity;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class CameraController extends HoverController {
		
		private const KEY_DISTANCE_SPEED:Number = 8;
		private const WHEEL_DISTANCE_SPEED:Number = 16;
		
		private var stage:Stage;
		private var panIncrement:Number = 0;
		private var tiltIncrement:Number = 0;
		private var distanceIncrement:Number = 0;
		private var tiltSpeed:Number = -1.5;
		private var panSpeed:Number = -1.5;
		private var lastX:Number;
		private var lastY:Number;
		private var startX:Number;
		private var camera:Entity;
		private var paused:Boolean;
		
		public var activated:Boolean = true;
		
		public function CameraController(stage:Stage,targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000, minTiltAngle:Number = -90, maxTiltAngle:Number = 90, minPanAngle:Number = NaN, maxPanAngle:Number = NaN, steps:uint = 8, yFactor:Number = 2, wrapPanAngle:Boolean = false) {
			super(targetObject, lookAtObject, panAngle, tiltAngle, distance, minTiltAngle, maxTiltAngle, minPanAngle, maxPanAngle, steps, yFactor, wrapPanAngle);
			this.stage = stage;
			camera = targetObject;
			iniListeners();
		}
		
		private function iniListeners():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			if (!paused) this.distance -= e.delta * WHEEL_DISTANCE_SPEED;
			trace(distance)
		}
		
		private function onMouseDown(e:MouseEvent):void {
			if (!paused) {
				if (activated) {
					lastX = stage.mouseX;
					lastY = stage.mouseY;
					
					startX = stage.mouseX;
					
					stage.addEventListener(Event.ENTER_FRAME, mouseUpdate);
					stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				}
			}
		}
		
		private function mouseUpdate(e:Event):void {
			
			var currentX:Number = stage.mouseX;
			var currentY:Number = stage.mouseY;
			
			if (currentX < lastX || currentX > lastX) {
				panIncrement = panSpeed * calcDirection(lastX - currentX);
			} else {
				panIncrement = 0;
			}
			
			if (currentY < lastY || currentY > lastY) {
				tiltIncrement = tiltSpeed * calcDirection(lastY - currentY);
			} else {
				tiltIncrement = 0;
			}

			lastX = stage.mouseX;
			lastY = stage.mouseY;
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(Event.ENTER_FRAME, mouseUpdate);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			panIncrement = 0;
			tiltIncrement = 0;
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if (!paused) {
				if (activated) {
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
							distanceIncrement = KEY_DISTANCE_SPEED;
							break;
						case Keyboard.X:
							distanceIncrement = -KEY_DISTANCE_SPEED;
							break;
					}
				}
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void {
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
		}
		
		private function calcDirection(num:Number):int {
			if (num < 0) {
				return -1;
			} else if (num > 0) {
				return 1
			} else {
				return 0;
			}
		}
		
		public function updateController():void {
			this.panAngle += panIncrement;
			this.tiltAngle += tiltIncrement;
			this.distance += distanceIncrement;
		}
		
		public function pause():void {
			paused = true;
		}
		
		public function resume():void {
			paused = false;
		}
		
	}
}