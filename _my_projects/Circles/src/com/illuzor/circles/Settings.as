package com.illuzor.circles {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Settings {
		
		public static var isGoogle:Boolean = true;
		public static var lang:String = "en";
		public static var dispatcher:EventDispatcher;
		
		public static function dispatch():void {
			dispatcher.dispatchEvent(new Event(Event.COMPLETE, true));
		}
		
	}
}