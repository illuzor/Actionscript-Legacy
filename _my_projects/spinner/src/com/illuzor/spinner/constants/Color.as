package com.illuzor.spinner.constants {
	
	import com.illuzor.spinner.utils.intRandom;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Color {
		
		public static const GREEN:uint = 0x82b30c;
		public static const RED:uint = 0xfe5126;
		public static const BLUE:uint = 0x0e33e8;
		public static const YELLOW:uint = 0xe8c319;
		public static const PURPLE:uint = 0xcd06e5;
		public static const ORANGE:uint = 0xec7f0a;
		
		private static var colors:Vector.<uint> = new<uint>[GREEN, RED, BLUE, YELLOW, PURPLE, ORANGE];
		
		public static function getColors(amount:uint):Vector.<uint> {
			var colorsCopy:Vector.<uint> = colors.slice(0, colors.length);
			var resultColors:Vector.<uint> = new Vector.<uint>();
			
			var counter:uint = 0;
			while (counter < amount) {
				trace(counter)
				var color:uint = colorsCopy.splice(intRandom(0, colorsCopy.length - 1), 1)[0];
				resultColors.push(color);
				counter++;
			}
			return resultColors;
		}
		
		public static function randomizeColors(initColors:Vector.<uint>):Vector.<uint> {
			var colorsCopy:Vector.<uint> = initColors.slice(0, initColors.length);
			var randomizedColors:Vector.<uint> = new Vector.<uint>();
			while (colorsCopy.length) {
				var color:uint = colorsCopy.splice(intRandom(0, colorsCopy.length - 1), 1)[0];
				randomizedColors.push(color);
			}
			return randomizedColors;
		}
		
	}
}