package com.illuzor.otherside.events {
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class ControlManagerEvent extends Event {
		
		public static const LEFT:String = "goLeft";
		public static const RIGHT:String = "goRight";
		public static const STOP:String = "stopMoving";
		
		public function ControlManagerEvent(type:String) { 
			super(type);
		} 
		
	}
}