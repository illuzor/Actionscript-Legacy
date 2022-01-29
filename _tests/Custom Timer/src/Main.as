package{
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var timer:NewTimer;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var button:Button = new Button("start");
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, start);
			
			var button1:Button = new Button("stop");
			addChild(button1);
			button1.y = 60;
			button1.addEventListener(MouseEvent.CLICK, stop);
			
			var button2:Button = new Button("pause");
			addChild(button2);
			button2.y = 120;
			button2.addEventListener(MouseEvent.CLICK, pause);
			
			var button3:Button = new Button("resume");
			addChild(button3);
			button3.y = 180;
			button3.addEventListener(MouseEvent.CLICK, resume);
			
			
			timer = new NewTimer(2000, 5);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			//timer.start();
		}
		
		private function onTimer(e:TimerEvent):void {
			trace("timer");
			if (e.type == TimerEvent.TIMER_COMPLETE) trace("timer complete");
		}
		
		private function start(e:MouseEvent):void {
			timer.start();
		}
		
		private function stop(e:MouseEvent):void {
			timer.stop();
		}
		
		private function pause(e:MouseEvent):void {
			timer.pause();
		}
		
		private function resume(e:MouseEvent):void {
			timer.start();
		}
		
		
	}
	
}