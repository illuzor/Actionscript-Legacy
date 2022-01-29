package com.illuzor.otherside.errors {
	
	import com.illuzor.otherside.debug.log;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class ControllerError extends Error{
		
		public function ControllerError(message:String, id:uint = 0) {
			name = "ControllerError";
			super(name + ": " + message, id);
		}
		
	}
}