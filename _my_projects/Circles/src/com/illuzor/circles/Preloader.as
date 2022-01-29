package com.illuzor.circles {
	
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Preloader extends Sprite {
		private var rotator:Sprite;
		
		public function Preloader() {
			if (stage) onAdded();
			else addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			addRotator();
			
			var loader:Loader = new Loader();
			loader.load(new URLRequest("game.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}
		
		private function addRotator():void {
			rotator = new Sprite();
			addChild(rotator);
			rotator.cacheAsBitmap = true;
			
			rotator.x = stage.stageWidth / 2;
			rotator.y = stage.stageHeight / 2;
			
			var circle1:Shape = getCircle(0x2538CB);
			circle1.x = -40;
			rotator.addChild(circle1);
			
			var circle2:Shape = getCircle(0x81B30C);
			circle2.x = 40;
			rotator.addChild(circle2);
			
			var circle3:Shape = getCircle(0xFF5126);
			circle3.y = -40;
			rotator.addChild(circle3);
			
			var circle4:Shape = getCircle(0xDAB831);
			circle4.y = 40;
			rotator.addChild(circle4);
			
			addEventListener(Event.ENTER_FRAME, onRotate);
		}
		
		private function onRotate(e:Event):void {
			rotator.rotation += 5;
		}
		
		private function getCircle(color:uint):Shape {
			var circle:Shape = new Shape();
			circle.graphics.beginFill(color);
			circle.graphics.drawCircle(0, 0, 20);
			circle.graphics.endFill();
			return circle;
		}
		
		private function onLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onLoaded);
			addChild(e.target.content);
			addEventListener(Event.COMPLETE, goToStart);
		}
		
		private function goToStart(e:Event):void {
			removeEventListener(Event.COMPLETE, goToStart);
			TweenLite.to(rotator, .5, { scaleX:0, scaleY:0, ease:Back.easeIn, onComplete:removeRotator } );
		}
		
		private function removeRotator():void {
			removeEventListener(Event.ENTER_FRAME, onRotate);
			removeChild(rotator);
			rotator = null;
		}
		
	}
}