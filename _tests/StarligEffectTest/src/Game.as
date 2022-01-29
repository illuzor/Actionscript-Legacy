package  {
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Game extends Sprite {
		private var singleEffect :ImgEffect;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			/*effect = new ImgEffect();
			effect.x = 300;
			effect.y = 300;
			addChild(effect);*/
			
			singleEffect = new ImgEffect();
			singleEffect.x = singleEffect.y = 300;
			addChild(singleEffect);
			
			/*
			
			*/
			
			var timer:Timer = new Timer(3000, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTimer(e:TimerEvent):void {
			singleEffect.bang();
			
			var timer:Timer = new Timer(2000, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onNewTimer);
		}
		
		private function onNewTimer(e:TimerEvent):void {
			removeChild(singleEffect);
			var sx:uint;
			var sy:uint;
			
			for (var i:int = 0; i < 50; i++) {
				var effect:ImgEffect = new ImgEffect();
				effect.x = sx * 34 + 50;
				effect.y = sy * 30 + 200;
				addChild(effect);
				if (sx*34 >= stage.stageWidth - 80) {
					sx = 0;
					sy++;
				} else {
					sx++
				}
			}
			
			var timer:Timer = new Timer(3000, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onSecondTimer);
		}
		
		private function onSecondTimer(e:TimerEvent):void {
			//effect.bang();
			for (var i:int = 0; i < numChildren; i++) {
				var temp:ImgEffect = getChildAt(i) as ImgEffect;
				temp.bang();
			}
		}

	}
}