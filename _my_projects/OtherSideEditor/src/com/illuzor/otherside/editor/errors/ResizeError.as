package com.illuzor.otherside.editor.errors {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class ResizeError extends Error {
		
		public function ResizeError(message:String, id:uint = 0) {
			name = "Resize Error";
			super(name + ": " + message, id);
		}
		
	}
}