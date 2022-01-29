package {
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.TweenLite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.greensock.easing.*;
	import flash.utils.Timer;
	import scaleform.gfx.Extensions;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	[SWF(width="1600", height="400", frameRate="30", backgroundColor="#FFFFFF")]
	//[SWF(width = "512", height = "128", frameRate = "30", backgroundColor = "#FFFFFF")]
	
	public class Main extends Sprite {
		private var container:Sprite;
		private var redLabel:Shape;
		private var welcome:Bitmap;
		private var items:Array;
		private var on:Boolean;
		
		private const size:uint = 1024;
		
		public function Main():void {
			Extensions.enabled = true;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			initialize();
		}
		
		private function initialize():void {
			on = false;
			container = new Sprite();
			container.alpha = 0;
			addChild(container);
			
			welcome = new Bitmap(new Welcome);
			welcome.smoothing = true;
			welcome.alpha = 0;
			welcome.width = stage.stageWidth
			welcome.height = stage.stageHeight;
			//welcome.x = (stage.stageWidth-welcome.width) / 2;
			//welcome.y = (stage.stageHeight-welcome.height) / 2;
			container.addChild(welcome);
			
			redLabel = new Shape();
			redLabel.graphics.beginFill(0xFF0000);
			redLabel.graphics.drawRect(0, -stage.stageHeight / 2, stage.stageWidth, stage.stageHeight);
			redLabel.graphics.endFill();
			redLabel.y = stage.stageHeight / 2;
			container.addChild(redLabel);
			//start();
		}
		
		public function start():void {
			if (!on) {
				on = true;
				TweenLite.to(container, 2, { alpha:1, onComplete:showWelcome } );
				TweenLite.to(redLabel, 1, { scaleY:0, ease:Cubic.easeIn, delay:1.9 } );
			}
		}
		
		private function showWelcome():void {
			welcome.alpha = 1;
			TweenLite.to(welcome, 3, { z:-4000,delay:3,onComplete:removeWelcome } );
		}
		
		private function removeWelcome():void {
			container.removeChild(welcome);
			var intro:IntroObject = new IntroObject();
			container.addChild(intro);
			intro.width = stage.stageWidth;
			intro.height = stage.stageHeight;
			addElements();
		}
		
		public function stop():void {
			TweenLite.to(container, 3, { alpha:0,onComplete:initialize } );
		}
		
		/*private function clear():void {
			initialize()
		}*/
		
		public function showItem(num:uint):void {
			items[num].visible = true;
			TweenLite.to(items[num], 2, { alpha:1 } );
		}
		
		private function addElements():void {
			items = [];
			for (var i:int = 0; i < 4; i++) {
				var item:Circle = new Circle();
				item.tf.text = String(i + 1);
				item.visible = false;
				item.alpha = 0;
				items.push(item);
				item.x = i * size;
				container.addChild(item);
				item.width = item.height = size;
			}
			/*var timer:Timer = new Timer(80);
			timer.addEventListener(TimerEvent.TIMER, updateItems);
			timer.start();*/
			//showItem(0)
			addEventListener(Event.ENTER_FRAME,updateItems )
		}
		
		private function updateItems(e:Event):void {
			for (var i:int = 0; i < items.length; i++) {
				items[i].rot.rotation += 2;
			}
		}
		
	}
}