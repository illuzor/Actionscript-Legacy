package {
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class BezierTool {
		
		public static function convertToPoints(points:Array, distance:uint):Vector.<Point> {
			var result:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < points.length; i += 3) {
				if (i == points.length - 1) break;
				var segment:Vector.<Point> = approxSegment(points[i], points[i + 1], points[i + 2], points[i + 3], distance);
				result = result.concat(segment);
			}
			return result;
		}
		
		private static function approxSegment(pt0:Point, pt1:Point, pt2:Point, pt3:Point, numofPoint:int):Vector.<Point> {
			var n:uint = 1000;
			
			var fulllength:Number = 0;
			
			var s:Number = 1 / (n - 1);
			var tt:Array = [];
			var PP:Array = [];
			var cc:Array = [];
			
			
			for (var i:int = 0; i < n; i++) {
				tt[i] = i * s;
				PP[i] = new Point(calcX(tt[i], pt0.x, pt1.x, pt2.x, pt3.x), calcY(tt[i], pt0.y, pt1.y, pt2.y, pt3.y));
				if (i > 0) {
					cc[i] = getDistance(PP[i], PP[i - 1]);
					fulllength += cc[i];
				}
			}
			
			var dd:Array = [];
			dd[0] = 0;
			for (var j:int = 1; j < n; j++) {
				dd[j] = dd[j - 1] + cc[j];
			}
			for (var k:int = 1; k < n; k++) {
				dd[k] = dd[k] / dd[n - 1];
			}
			
			var m:int = (fulllength / numofPoint);
			var QQ:Vector.<Point> = new Vector.<Point>
			
			if (m != 0) {
				var step:Number = 1 / m;
				
				for (var l:int = 0; l < m; l++) {
					var d:Number = l * step;
					var ii:int = findIndex(dd, d);
					var u:Number = (d - dd[ii]) / (dd[ii + 1] - dd[ii]);
					var t:Number = (ii + u) * s;
					
					var qx:int = calcX(t, pt0.x, pt1.x, pt2.x, pt3.x);
					var qy:int = calcY(t, pt0.y, pt1.y, pt2.y, pt3.y)
					
					QQ[l] = new Point(qx, qy);
				}
			}
			
			return QQ;
		}
		
		private static function calcX(t:Number, x0:Number, x1:Number, x2:Number, x3:Number):Number {
			return x0 * Math.pow(1 - t, 3) +
				   x1 * 3 * t * Math.pow(1 - t, 2) +
				   x2 * 3 * Math.pow(t, 2) * (1 - t) +
				   x3 * Math.pow(t, 3); 
		}
		
		private static function calcY(t:Number, x0:Number, x1:Number, x2:Number, x3:Number):Number {
			return x0 * Math.pow(1 - t, 3) +
				   x1 * 3 * t * Math.pow(1 - t, 2) +
				   x2 * 3 * Math.pow(t, 2) * (1 - t) +
				   x3 * Math.pow(t, 3); 
		}
		
		private static function getDistance(p1:Point, p2:Point):Number {
			var xDelta:Number = p1.x - p2.y;
			var yDelta:Number = p1.y - p2.y;
			return Math.sqrt(Math.pow(xDelta, 2) + Math.pow(yDelta, 2));
		}
		
		private static function findIndex(dd:Array, d:Number):int {
			var i:int = 0;
			for (var j:int = 0; j < dd.length; j++) {
				if (d > dd[j]) i = j;
			}
			return i;
		}
		
		
	}
}