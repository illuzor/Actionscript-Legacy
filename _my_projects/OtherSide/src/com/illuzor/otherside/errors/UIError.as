package com.illuzor.otherside.errors {
	
	import com.illuzor.otherside.debug.log;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class UIError extends Error {
		
		public function UIError(message:String="", id:int=0) {
			name = "UIError";
			super(name + ": " + message, id);
		}
		
	}
}