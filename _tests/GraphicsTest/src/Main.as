package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	public class Main extends Sprite {
		
		public function Main():void {
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var starling:Starling = new Starling(GraphicsTest, stage, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			starling.start();
		}
	
	}
}