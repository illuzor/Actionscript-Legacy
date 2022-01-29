package com.illuzor.circles.ui.screens {
	
	import starling.display.Shape;
	import starling.display.Sprite;
	

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ChangingCircle extends Sprite {
		
		private var _size:uint = 0;
		private var shape:Shape;
		
		public function ChangingCircle() {
			shape = new Shape();
			addChild(shape);
		}
		
		public function get size():uint {
			return _size;
		}
		
		public function set size(value:uint):void {
			_size = value;
			shape.graphics.clear();
			shape.graphics.beginFill(0xFFFFFF);
			shape.graphics.drawCircle(0, 0, _size);
		}
		
	}
}