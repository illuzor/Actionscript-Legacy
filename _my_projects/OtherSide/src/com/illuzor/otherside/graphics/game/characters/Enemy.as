package com.illuzor.otherside.graphics.game.characters {
	
	import com.illuzor.otherside.interfaces.IMovable;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Enemy extends Image implements IMovable {
		
		private var counter:uint = 0;
		private var pointsX:Vector.<int>;
		private var pointsY:Vector.<int>;
		
		private var pointsLastX:Vector.<int> = new Vector.<int>();
		private var pointsLastY:Vector.<int> = new Vector.<int>();
		
		private var position:Point;
		private var curveX:Vector.<int>;
		private var curveY:Vector.<int>;
		
		public function Enemy(texture:Texture, position:Point, curveX:Vector.<int> = null, curveY:Vector.<int> = null) {
			super(texture);
			this.curveY = curveY;
			this.curveX = curveX;
			this.position = position;
			this.pointsX = curveX;
			this.pointsY = curveY;
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			
			var firstPoint:Point = new Point(curveX[curveX.length - 1], curveY[curveY.length - 1])
			
			if(!firstPoint.equals(position))calcLastDistance(firstPoint, position);
		}
		
		private function calcLastDistance(firt:Point, last:Point):void {
			var distance:Number = Point.distance(firt, last);
			var segments:uint = distance / 5;
			for (var i:int = 0; i <= segments; i++) {
				var calcedPoint:Point = Point.interpolate(firt, last, 1-(1 / segments * i));
				pointsLastX.push(calcedPoint.x);
				pointsLastY.push(calcedPoint.y);
			}
		}
		
		public function move():void {
			if (pointsLastX) {
				this.x = pointsX[counter];
				this.y = pointsY[counter];
				if (counter < pointsX.length - 1) {
					counter++;
				} else {
					if (curveX) {
						counter = 0;
						pointsX = pointsLastX;
						pointsY = pointsLastY;
						curveX = null;
						curveY = null;
						if (pointsLastX.length == 0) {
							pointsLastX = null;
							pointsLastY = null;
						}
					} else {
						pointsLastX = null;
						pointsLastY = null;
					}
				}
			}
		}
		
		override public function dispose():void {
			pointsX = null;
			pointsY = null;
			super.dispose();
		}
		
	}
}