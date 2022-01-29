package com.illuzor.otherside.errors {
	

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class StorageManagerError extends Error {
		
		public function StorageManagerError(message:String="", id:int=0) {
			name = "StorageManagerError";
			super(name + ": " + message, id);
		}
		
	}
}