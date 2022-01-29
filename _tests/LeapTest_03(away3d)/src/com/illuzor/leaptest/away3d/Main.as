package com.illuzor.leaptest.away3d {
	
	import com.leapmotion.leap.events.LeapEvent;
	import com.leapmotion.leap.LeapMotion;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		private var leap:LeapMotion;
		private static var _stage:Stage;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			start();
			_stage = stage;
			//initLeap()
		}
		
		/*private function initLeap():void {
			leap = new LeapMotion();
			
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_INIT, onLeapEvent);
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_CONNECTED, onLeapEvent );
			//leap.controller.addEventListener( LeapEvent.LEAPMOTION_DISCONNECTED, onLeapEvent );
			//leap.controller.addEventListener( LeapEvent.LEAPMOTION_EXIT, onLeapEvent );
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_TIMEOUT, onLeapEvent );
		}
		
		private function onLeapEvent(e:LeapEvent):void {
			trace(e.type);
			switch (e.type) {
				case LeapEvent.LEAPMOTION_INIT:
					
				break;
				
				case LeapEvent.LEAPMOTION_CONNECTED:
					trace("Leap connected", leap.isConnected());
					start();
				break;
				
				case LeapEvent.LEAPMOTION_TIMEOUT:
					
				break;
			}
		}*/
		
		private function start():void {
			addChild(new MainScreen());
		}
		
		public static function getStage():Stage {
			return _stage;
		}
		
	}
	
}