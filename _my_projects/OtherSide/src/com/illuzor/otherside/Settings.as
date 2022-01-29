package com.illuzor.otherside {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class Settings {
		
		private static var _lang:String;
		
		public static var langConfig:Object;
		public static var soundEnabled:Boolean = true;
		public static var musicEnabled:Boolean = true;
		public static var vibroEnabled:Boolean = true;
		
		public static function get lang():String {
			return _lang;
		}
		
		public static function set lang(value:String):void {
			if (value != "ru") _lang = "en";
			else _lang = value;
		}
		
	}
}