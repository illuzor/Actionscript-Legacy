package com.illuzor.circles.events {
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class PlayEvent extends Event {
		
		public static const SIGN_IN_SUCCESS:String = "singSuccess";
		public static const SIGN_IN_FAIL:String = "singFail";
		
		public function PlayEvent(type:String) { 
			super(type);
			
		} 
	}
}