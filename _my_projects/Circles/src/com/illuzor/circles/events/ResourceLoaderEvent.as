package com.illuzor.circles.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ResourceLoaderEvent extends Event {
		
		public static const RESOURCES_LOADED:String = "resourcesLoader";
		
		public function ResourceLoaderEvent(type:String) { 
			super(type);
		} 
		
	}
}