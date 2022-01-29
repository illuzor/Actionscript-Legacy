package com.illuzor.spinner.assets {
	
	import com.hurlant.util.der.ByteString;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Keys {
		
		[Embed(source = "../../../../../assets/keys/settings.key", mimeType = "application/octet-stream")]
		private static const SettingsKeyClass:Class;
		
		[Embed(source = "../../../../../assets/keys/distriqt.key", mimeType = "application/octet-stream")]
		private static const DistriqtClass:Class;
		
		
		public static function get settingsKey():ByteArray {
			return new SettingsKeyClass() as ByteArray;
		}
		
		public static function get aneKey():String {
			return new DistriqtClass();
		}
		
	}
}