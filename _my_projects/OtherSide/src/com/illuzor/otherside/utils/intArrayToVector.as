package com.illuzor.otherside.utils {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public function intArrayToVector(array:Array):Vector.<int> {
		var vector:Vector.<int> = new Vector.<int>(array.length, true);
		for (var i:int = 0; i < array.length; i++) {
			vector[i] = array[i];
		}
		return vector;
	}
	
}