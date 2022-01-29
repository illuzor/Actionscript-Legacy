package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		private static var _container:Sprite;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var container:Sprite = new Sprite();
			container.x = 600;
			addChild(container);
			_container = container;
			container.graphics.beginFill(0x408080, 1);
			container.graphics.drawRect(0, 0, 600, 800);
			container.graphics.endFill();
			
			var separator:Shape = new Shape();
			addChild(separator);
			separator.graphics.lineStyle(1, 0x0, .7);
			separator.graphics.moveTo(600, 0);
			separator.graphics.lineTo(600, 800);
			
			var starling:Starling = new Starling(StarlingDisplay, stage, new Rectangle(0, 0, 600, 800));
			starling.antiAliasing = 8;
			starling.start();
		}
		
		public static function get container():Sprite {
			return _container;
		}
		
	}
}