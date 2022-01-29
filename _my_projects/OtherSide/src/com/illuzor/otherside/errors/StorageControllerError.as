package com.illuzor.otherside.errors {
	
	import com.illuzor.otherside.debug.log;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class StorageControllerError extends Error {
		
		public function StorageControllerError(message:String="", id:int=0) {
			name = "StorageManagerError";
			super(name + ": " + message, id);
		}
		
	}
}