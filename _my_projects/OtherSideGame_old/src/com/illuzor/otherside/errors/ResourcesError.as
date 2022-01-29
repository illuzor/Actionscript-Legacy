package com.illuzor.otherside.errors {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ResourcesError extends Error {
		
		public function ResourcesError(message:String, id:uint = 0) {
			name = "ResourcesError";
			super(name + ": " + message, id);
		}
		
	}
}