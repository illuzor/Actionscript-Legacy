package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var timer:Timer;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//addEventListener(Event.ENTER_FRAME, onEvent);
			//addEventListener(Event.EXIT_FRAME, onEvent);
			//addEventListener(Event.RENDER, onEvent);
			
			timer = new Timer(200, 0);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			timer.start();
		}
		
		private function onTimer(e:TimerEvent):void {
			trace(e.type, "timer");
		}
		
		private function onEvent(e:Event):void {
			//trace(e.type);
			//if (e.type == Event.EXIT_FRAME) stage.invalidate();
		}
		
	}
	
}