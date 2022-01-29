package com.illuzor.otherside.events {
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class ResourceControllerEvent extends Event {
		
		public static const INITIAL_LOAD_COMPLETE:String = "initialLoadComplete";
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		public function ResourceControllerEvent(type:String) { 
			super(type);
		} 
	}
	
}