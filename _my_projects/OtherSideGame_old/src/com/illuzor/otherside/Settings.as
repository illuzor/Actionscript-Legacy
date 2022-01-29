package com.illuzor.otherside {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Settings {
		
		private static var _lang:String = "";
		private static var _langConfig:Object;
		
		public static function get lang():String {
			return _lang;
		}
		
		public static function set lang(value:String):void {
			if (_lang == "")_lang = value;
		}
		
		public static function get langConfig():Object {
			return _langConfig;
		}
		
		public static function set langConfig(value:Object):void {
			if (!_langConfig) _langConfig = value;
		}
		
	}
}