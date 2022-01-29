package com.illuzor.circles.events {
	
	import starling.events.Event;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class PauseEvent extends Event {
		
		public static const PLAY:String = "back";
		public static const MENU:String = "menu";
		public static const REPLAY:String = "replay";
		
		public function PauseEvent(type:String) { 
			super(type);
		} 
		
	}
}