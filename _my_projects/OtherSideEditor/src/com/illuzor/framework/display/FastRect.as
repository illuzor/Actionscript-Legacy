package com.illuzor.framework.display {
	
	import flash.display.Shape;
	
	/**
	 * Класс быстрого прямоугольника
	 * 
	 * @author illuzor || illuzor@gmail.com
	 */
	
	public class FastRect extends Shape {
		
		private var _color:uint;
		private var _width:uint;
		private var _height:uint;
		private var _aplha:Number;
		
		public function FastRect(width:uint, height:uint, color:uint = 0x0, rectAlpha:Number = 1) {
			_color = color;
			_width = width;
			_height = height;
			_aplha = rectAlpha;
			draw();
		}
		
		public override function set width (value:Number):void {
			_width = value;
			draw();
		}
		
		public override function get width():Number {
			return _width;
		}
		
		public override function set height (value:Number):void {
			_height = value;
			draw();
		}
		
		public override function get height():Number {
			return _height;
		}
		
		public function get color():uint {
			return _color;
		}
		
		public function set color(value:uint):void {
			_color = value;
			draw();
		}
		
		override public  function get alpha():Number {
			return _aplha;
		}
		
		override public  function set alpha(value:Number):void {
			_aplha = value;
			draw();
		}
		
		public function setSize(w:uint, h:uint):void {
			_width = w;
			_height = h;
			draw();
		}

		private function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(_color, _aplha);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
		}
		
	}
}