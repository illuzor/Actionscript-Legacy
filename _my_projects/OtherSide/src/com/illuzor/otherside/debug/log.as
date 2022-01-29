package com.illuzor.otherside.debug {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public function log(...rest):void {
		var string:String = rest.join(" ")
		trace(string);
		
		CONFIG::debug {
			Logger.appendString(string);
		}
		
	}
}