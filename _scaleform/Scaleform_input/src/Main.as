package {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import scaleform.clik.controls.Button;
	import scaleform.gfx.Extensions;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		private var totalItems:uint = 4;
		private var currentItem:uint = 0;
		private var butonContainer:Sprite;
		private var imageContainer:Sprite;
		private var imageScaled:Boolean;
		private var started:Boolean;
		
		public function Main():void {
			Extensions.enabled = true;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//addChild(new FlintScreen);
			//start();
		}
		
		public function start():void {
			if (!started) {
				started = true;
				var timer:Timer = new Timer(800, 1);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, go)
			}
		}
		
		private function go(e:TimerEvent):void {
			addChild(new FastRect(stage.stageWidth, stage.stageHeight, 0x80FF80, .4));
			butonContainer = new Sprite();
			butonContainer.x = 50;
			butonContainer.y = 106;
			addChild(butonContainer);
			for (var i:int = 0; i < 5; i++) {
				var button:ScaleformButton = new ScaleformButton();
				button.y = i * 56;
				button.label = "Item " + String(i + 1);
				button.alpha = 0;
				button.x = 100;
				TweenLite.to(button, .7, { alpha:1, x:0, ease:Back.easeOut, delay:.3 * i } );
				//if (i == 0) button.selected = true;
				butonContainer.addChild(button);
			}
			
			var images:Vector.<Bitmap> = ImageFactory.getImages();
			imageContainer = new Sprite();
			for (var j:int = 0; j < images.length; j++) {
				imageContainer.addChild(images[j]);
			}
			imageContainer.scaleX = imageContainer.scaleY = .4;
			imageContainer.x = 320;
			imageContainer.y = 144;
			imageContainer.alpha = 0;
			TweenLite.to(imageContainer,1, {alpha:1})
			addChild(imageContainer);
			
			activateButton();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keysHandler);
		}
		
		private function keysHandler(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.U && !imageScaled) {
				//up
				if (currentItem > 0) {
					currentItem--;
				} else {
					currentItem = totalItems;
				}
				activateButton();
			} else if (e.keyCode == Keyboard.J && !imageScaled) {
				//down
				if (currentItem < totalItems) {
					currentItem++;
				} else {
					currentItem = 0;
				}
				activateButton();
			} else if (e.keyCode == Keyboard.H) {
				// left
			} else if (e.keyCode == Keyboard.K) {
				// right
			} else if (e.keyCode == Keyboard.L) {
				// enter
				if (!imageScaled) {
					TweenLite.to(imageContainer, .8, { x:0, y:0, scaleX:1, scaleY:1 } );
				} else {
					TweenLite.to(imageContainer, .8, { x:320, y:144, scaleX:.4, scaleY:.4 } );
				}
				imageScaled = !imageScaled;
			}
		}
		
		private function activateButton():void {
			for (var i:int = 0; i < totalItems + 1; i++) {
				(imageContainer.getChildAt(i) as DisplayObject).visible = false;
				var tempButton:ScaleformButton = butonContainer.getChildAt(i) as ScaleformButton;
				tempButton.selected = false;
			}
			(butonContainer.getChildAt(currentItem) as ScaleformButton).selected = true;
			(imageContainer.getChildAt(currentItem) as DisplayObject).visible = true;
		}
		
	}
}