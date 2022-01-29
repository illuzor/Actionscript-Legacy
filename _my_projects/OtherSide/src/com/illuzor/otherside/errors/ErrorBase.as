package com.illuzor.otherside.errors {
	
	import com.illuzor.otherside.debug.log;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class ErrorBase extends Error {
		
		public function ErrorBase(message:String = "", id:int = 0) {
			log(name + ": " + message);
			super(name + ": " + message, id);
		}
		
	}
}