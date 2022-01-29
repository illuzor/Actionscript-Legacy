package com.illuzor.spinner.graphics {
	
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import com.illuzor.spinner.constants.ShapeType;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class RotatorShape extends Sprite {
		
		private var _radius:Number = 0;
		
		private var colors:Vector.<uint>;
		private var rotationStep:Number;
		private var type:uint;
		private var pointer:uint = 0;
		private var totalColors:uint;
		private var rotationDest:Number = 0;
		private var partTexture:Texture;
		
		public function RotatorShape(type:uint, colors:Vector.<uint>, partTexture:Texture) {
			this.partTexture = partTexture;
			this.colors = colors;
			this.type = type;
			
			switch (type) {
				case ShapeType.CIRCLE:
					rotationStep = 180;
				break;
				case ShapeType.TRIANGLE:
					rotationStep = 120;
				break;
				case ShapeType.SQUARE:
					rotationStep = 90;
				break;
				case ShapeType.PENTAGON:
					rotationStep = 72;
				break;
				case ShapeType.HEXAGON:
					rotationStep = 60;
				break;
			}
			totalColors = colors.length;
			makeShape();
		}
		
		protected function makeShape():void {
			for (var i:int = 0; i < type; i++) {
				var image:Image = new Image(partTexture);
				addChild(image);
				image.pivotX = image.width >> 1;
				image.pivotY = image.height;
				image.rotation = deg2rad(rotationStep * i);
				image.color = colors[i];
				if (i == 0)
					_radius = image.height;
			}
		}
		
		public function rotateCW():void {
			this.rotation = rotationDest;
			rotationDest = this.rotation + deg2rad(rotationStep);
			decreasePointer();
			TweenLite.to(this, .16, { rotation:rotationDest, ease:Linear.easeNone } );
		}
		
		public function rotateCCW():void {
			this.rotation = rotationDest;
			rotationDest = this.rotation - deg2rad(rotationStep);
			increasePointer();
			TweenLite.to(this, .16, { rotation:rotationDest, ease:Linear.easeNone } );
		}
		
		private function increasePointer():void {
			if (pointer < totalColors - 1) {
				pointer++;
			} else {
				pointer = 0;
			}
		}
		
		private function decreasePointer():void {
			if (pointer > 0) {
				pointer--;
			} else {
				pointer = totalColors - 1;
			}
		}
		
		public function get correntColor():uint {
			return colors[pointer];
		}
		
		public function get radius():Number {
			return _radius * this.scaleY;
		}
	
	}
}