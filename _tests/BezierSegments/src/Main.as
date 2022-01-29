package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	public class Main extends Sprite {
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var curves:Object = JSON.parse('{"c0":{"x":[20,20,523,52],"y":[20,20,426,260]}}');
			var points:Array = curvesToPoints(curves);
			trace(points);
			
			var time:uint = getTimer()
			
			trace(BezierTool.convertToPoints(points, 4));
			
			trace(getTimer() - time);
		}
		
		private function curvesToPoints(c:Object):Array {
			var arr:Array = [];
			for (var i:int = 0; i < c.c0.x.length; i++) {
				arr.push(new Point(c.c0.x[i], c.c0.y[i]));
			}
			return arr;
		}
		
	}
	
}