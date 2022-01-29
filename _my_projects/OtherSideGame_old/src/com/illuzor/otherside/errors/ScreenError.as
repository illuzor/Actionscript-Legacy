package com.illuzor.otherside.errors {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ScreenError extends Error {
		
		public function ScreenError(message:String, id:uint = 0) {
			name = "ScreenError";
			super(name + ": " + message, id);
		}
		
	}
}