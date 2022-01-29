package com.illuzor.otherside.events {
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ResourceManagerEvent extends Event {
		
		public static const RESOURCES_LOADED:String = "resLoaded";
		
		public function ResourceManagerEvent(type:String) { 
			super(type);
		} 
		
	}
}