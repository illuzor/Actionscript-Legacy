package{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		private var vect:Vector.<String> = new <String>["sdfs", "sfsf", "sgsgsg"]
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			for (var i:int = 0; i < vect.length; i++) {
				trace(vect[i])
			}
			
			for each (var item:String in vect) {
				trace(item)
			}
			
			for (var name:String in vect) {
				trace(name)
			}
		}
		
	}
	
}