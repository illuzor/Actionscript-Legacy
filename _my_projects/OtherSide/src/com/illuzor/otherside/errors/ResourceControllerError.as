package com.illuzor.otherside.errors {
	
	import com.illuzor.otherside.debug.log;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ResourceControllerError extends Error {
		
		public function ResourceControllerError(message:String="", id:int=0) {
			name = "ResourceControllerError";
			super(name + ": " + message, id);
		}
		
	}
}