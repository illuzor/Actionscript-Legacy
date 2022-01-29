package com.illuzor.otherside {
	
	import com.illuzor.otherside.controllers.AppController;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class Game extends Sprite {
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			AppController.setContainer(this);
		}
		
	}
}