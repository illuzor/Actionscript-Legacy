package {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import net.hires.debug.Stats;

	public class Main extends Sprite {
		
		private var circleShape:Shape;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			circleShape = new Shape();
			addChild(circleShape);
			
			addChild(new Stats());
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
		}
		
		private function onMouseEvent(e:MouseEvent):void {
			if (e.type == MouseEvent.MOUSE_DOWN) {
				circleShape.x = mouseX;
				circleShape.y = mouseY;
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			} else {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private function onEnterFrame(e:Event):void {
			var radius:Number = Point.distance(new Point(circleShape.x, circleShape.y), new Point(mouseX, mouseY));

			circleShape.graphics.clear();
			circleShape.graphics.lineStyle(2, 0x808000);
			circleShape.graphics.beginFill(0x0, .1);
			circleShape.graphics.drawCircle(0, 0, radius);
			circleShape.graphics.endFill();
		}
		
	}
}