package com.illuzor.spinner.utils {

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public function intRandom(minNum:uint, maxNum:uint):uint {
		return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
	}
	
}