package com.illuzor.circles.ui {
	
	import com.greensock.TweenLite;
	import com.illuzor.circles.tools.Assets;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Circle extends Sprite {
		
		private var _color:uint;
		private var image1:Image;
		private var image2:Image;
		private var size:uint;
		
		public function Circle(size:uint, circleColor:uint) {
			this.size = size;
			image1 = new Image(Assets.circleTexture);
			image1.width = image1.height = size;
			addChild(image1);
			pivotX = image1.width / 2;
			pivotY = image1.height / 2;
			image1.color = circleColor;
			_color = circleColor;
		}
		
		public function set position(point:Point):void {
			this.x = point.x;
			this.y = point.y;
		}
		
		public function get position():Point {
			return new Point(this.x, this.y);
		}
		
		public function get color():uint {
			return _color;
		}
		
		public function set color(value:uint):void {
			TweenLite.killTweensOf(image1);
			_color = value;
			image2 = new Image(Assets.circleTexture);
			image2.width = image2.height = size;
			image2.color = _color;
			addChildAt(image2, 0);
			TweenLite.to(image1, .3, { alpha:0, onComplete:clear } );
		}
		
		private function clear():void {
			removeChild(image1);
			image1.dispose();
			image1 = image2;
		}
		
	}
}