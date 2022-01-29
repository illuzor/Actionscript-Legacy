package com.illuzor.leaptest {
	import com.leapmotion.leap.events.LeapEvent;
	import com.leapmotion.leap.Finger;
	import com.leapmotion.leap.Frame;
	import com.leapmotion.leap.Hand;
	import com.leapmotion.leap.LeapMotion;
	import com.leapmotion.leap.Vector3;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		
		private var dots:Vector.<Shape> = new Vector.<Shape>();
		
		public function Main():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			createDots();
			var leap:LeapMotion = new LeapMotion();
			leap.controller.addEventListener(LeapEvent.LEAPMOTION_FRAME, update);
		}
		
		private function update(e:LeapEvent):void {
			
			var frame:Frame = e.frame;
			if ( frame.hands.length > 0 ) {

				var hand:Hand = frame.hands[0];
				var fingers:Vector.<Finger> = hand.fingers;
				
				if (fingers.length > 0) {
					
					for (var i:int = 0; i < fingers.length; i++) {
						var avgPos:Vector3 = Vector3.zero();
						avgPos = avgPos.plus(fingers[i].tipPosition);
						avgPos = avgPos.divide(fingers.length);
						dots[i].x = avgPos.x*5 + 400;
						dots[i].y = -avgPos.y*5 + 500;
						dots[i].scaleX = dots[i].scaleY = avgPos.z/20;
						trace("Hand has " + fingers.length + " fingers, average finger tip position: " + avgPos);
					}
					
					// Calculate the hand's average finger tip position
					/*var avgPos:Vector3 = Vector3.zero();
					for each (var finger:Finger in fingers)
						avgPos = avgPos.plus(finger.tipPosition);
					
					avgPos = avgPos.divide(fingers.length);
					
					dots[i].x = avgPos.x;
					dots[i].y = avgPos.y;*/
					//;
					//trace("Hand has " + fingers.length + " fingers, average finger tip position: " + avgPos);
				}
			}
		}
		
		private function createDots():void {
			for (var i:int = 0; i < 5; i++) {
				var dot:Shape = new Shape();
				dot.graphics.beginFill(0x804000, .3);
				dot.graphics.drawCircle(0, 0, 15);
				dot.graphics.endFill();
				dots.push(dot);
				addChild(dot);
			}
		}
	
	}

}