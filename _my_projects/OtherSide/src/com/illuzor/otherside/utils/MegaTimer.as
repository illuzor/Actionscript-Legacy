package com.illuzor.otherside.utils {
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	[Event(name = "timerComplete", type = "flash.events.TimerEvent")]
	[Event(name = "timer", type = "flash.events.TimerEvent")]
	
	public class MegaTimer extends EventDispatcher {
		
		private var timer:Timer;
		private var timerDelay:Number;
		private var timeFromStart:uint;
		private var afterPause:Boolean;
		
		public function MegaTimer(delay:Number, repeatCount:uint = 0) {
			trace("delay", delay)
			this.timerDelay = delay;
			timer = new Timer(timerDelay, repeatCount);
			timer.delay = timerDelay;
			timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerEvent);
		}
		
		private function onTimerEvent(e:TimerEvent):void {
			if (e.type == TimerEvent.TIMER) {
				
				dispatchEvent(new TimerEvent(TimerEvent.TIMER));
				timeFromStart = getTimer();
				
				if (afterPause) {
					timer.stop();
					timer.delay = timerDelay;
					timer.start();
					afterPause = false;
				}	
			}
			
			if (e.type == TimerEvent.TIMER_COMPLETE)
				dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
		}
		
		public function start(withDelay:uint = 0):void {
			if (withDelay != 0) {
				this.timerDelay = withDelay;
				timer.delay = withDelay;
			}
			timer.start();
			timeFromStart = getTimer();
		}
		
		public function pause():void {
			var timeDelta:uint = getTimer() - timeFromStart;
			timer.stop();
			timer.delay -= timeDelta;
			afterPause = true;
		}
		
		public function stop():void {
			timer.stop();
		}
		
		public function get currentCount():uint {
			return timer.currentCount;
		}
		
		public function get delay():Number {
			return timer.delay;
		}
		
		public function set delay(value:Number):void {
			timer.delay = value;
		}
		
		public function dispose():void {
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerEvent);
			timer = null;
		}
		
	}
}