package com.illuzor.circles.ui.screens {
	
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import com.illuzor.circles.constants.Colors;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class Background extends Sprite {
		
		private var colors:Vector.<uint>;
		private var counter:uint = 0;
		private var shape:Shape;
		private var firstPassed:Boolean;
		
		public function Background() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			colors = Colors.getColors(Colors.totalColor);
			showColor();
		}
		
		private function showColor():void {
			shape = new Shape();
			shape.graphics.beginFill(colors[counter]);
			shape.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			shape.graphics.endFill();
			addChild(shape);
			
			var time:Number = 3.7
			if (!firstPassed) {
				time = .8;
				firstPassed = true;
			}
			shape.alpha = 0;
			TweenLite.to(shape, time, { ease:Linear.easeNone, alpha:1, onComplete:nextColor } );
		}
		
		private function nextColor():void {
			if (numChildren > 1) removeChildAt(0);
			if (counter < Colors.totalColor-1) {
				counter++;
			} else {
				counter = 0;
			}
			if (stage) showColor();
		}
		
		override public function dispose():void {
			removeChildren();
			TweenLite.killTweensOf(shape);
			super.dispose();
		}
		
	}
}