package com.illuzor.bubbles.utils {
	
	/**
	 * Возвращает плюс один или минус один
	 * 
	 * @return +1 или -1
	 */
	public function plusOrMinus():int {
		if (Math.random() <= .5) return -1;
		return 1;
	}
	
}