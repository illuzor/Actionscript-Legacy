package com.illuzor.bubbles.utils {
	
	 /**
	 * Генератор (псевдо)случайного целого числа в заданном диапазоне.
	 * 
	 * @param	minNum Минимальное значение.
	 * @param	maxNum Максимальное значение.
	 * @return Сгенерированное число
	 */
	 
	 public function randomInt(minNum:Number, maxNum:Number):Number {
		return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
	}

}