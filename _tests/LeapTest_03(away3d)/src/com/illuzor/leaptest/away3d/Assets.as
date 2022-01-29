package com.illuzor.leaptest.away3d {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Assets {
		
		[Embed(source = "../../../../../assets/background.jpg")]
		private static const BackClass:Class;
		
		public static function get bacground():Bitmap {
			return new BackClass() as Bitmap;
		}
		
		[Embed(source = "../../../../../assets/floorTexture.jpg")]
		private static const FloorClass:Class;
		
		public static function get floorBitmap():Bitmap {
			return new FloorClass() as Bitmap;
		}
		
		[Embed(source = "../../../../../assets/cube1.jpg")]
		private static const Cube1Class:Class;
		
		public static function get cube1():Bitmap {
			return new Cube1Class() as Bitmap;
		}
		
		[Embed(source = "../../../../../assets/cube2.jpg")]
		private static const Cube2Class:Class;
		
		public static function get cube2():Bitmap {
			return new Cube2Class() as Bitmap;
		}
		
		[Embed(source = "../../../../../assets/cube3.jpg")]
		private static const Cube3Class:Class;
		
		public static function get cube3():Bitmap {
			return new Cube3Class() as Bitmap;
		}
		
		[Embed(source = "../../../../../assets/rotator.png")]
		private static const RotatorClass:Class;
		
		public static function get rotator():BitmapData {
			return (new RotatorClass() as Bitmap).bitmapData;
		}
		
	}
}