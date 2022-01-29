package display {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class AnimatedObject extends Sprite {
		
		private var bitmap:Bitmap = new Bitmap();
		private var currentFrame:uint;
		private var frames:Vector.<BitmapData>;
		
		public function AnimatedObject(frames:Vector.<BitmapData>) {
			this.frames = frames;
			addChild(bitmap);
			
			onTimerEvent();
			var timer:Timer = new Timer(35, frames.length-2);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerEvent);
		}
		
		private function onTimerEvent(e:TimerEvent = null):void {
			bitmap.bitmapData = frames[currentFrame];
			currentFrame++;
			if (e)
				if (e.type == TimerEvent.TIMER_COMPLETE)
					trace("onComplete");
		}
		
	}
}