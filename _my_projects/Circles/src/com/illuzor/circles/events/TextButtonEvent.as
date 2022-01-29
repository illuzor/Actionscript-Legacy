package com.illuzor.circles.events {
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class TextButtonEvent extends Event {
		
		public static const TRIGGERED:String = "bTriggered";
		
		public function TextButtonEvent(type:String, bubbles:Boolean=false) { 
			super(type, bubbles);
		} 
		
	}
}