package{
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			sortToMax([5, 2, 3, 1, 4]);
			sortToMax([122, 1, 121, 18, 144]);
			sortToMin([5, 2, 3, 1, 4]);
			sortToMin([122, 1, 121, 18, 144]);
		}
		
		private function sortToMax(arr:Array):void {
			for (var j:int = 1; j < arr.length; j++) {
				var key:int = arr[j];
				var i:int = j - 1;
				while (i>=0 && arr[i]>key) {
					arr[i + 1] = arr[i];
					i--;
				}
				arr[i + 1] = key;
			}
			trace(arr);
		}
		
		
		private function sortToMin(arr:Array):void {
			for (var j:int = 1; j < arr.length; j++) {
				var key:int = arr[j];
				var i:int = j - 1;
				while (i > 0 && arr[i] > key) {
					arr[i - 1] = arr[i];
					i--;
				}
				arr[i - 1] = key;
			}
			
			trace(arr)
		}
		
	}
	
}