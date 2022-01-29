package com.illuzor.otherside.tools {
	
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class Keys {
		
		[Embed(source = "../../../../../assets/keys/save.oskey", mimeType = "application/octet-stream")]
		private static const SaveKeyClass:Class;
		
		[Embed(source = "../../../../../assets/keys/distriqt.oskey", mimeType = "application/octet-stream")]
		private static const DistriqtClass:Class;
		
		public static function get saveKey():ByteArray {
			return new SaveKeyClass() as ByteArray
		}
		
		public static function get distriqtKet():ByteArray {
			return new DistriqtClass() as ByteArray
		}
		
	}
}