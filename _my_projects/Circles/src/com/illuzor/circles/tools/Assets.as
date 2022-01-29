package com.illuzor.circles.tools {
	
	import flash.utils.ByteArray;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Assets {
		
		[Embed(source = "../../../../../assets/settings.key", mimeType = "application/octet-stream")]
		private static const KeyClass:Class;
		
		[Embed(source = "../../../../../assets/distriqt.key", mimeType = "application/octet-stream")]
		private static const DistriqtKeyClass:Class;
		
		public static var atlas:TextureAtlas;
		public static var lang:Object;
		private static var font:BitmapFont;
		private static var _circleTexture:Texture;
		
		public static function setFont(fontXML:XML):void {
			font = new BitmapFont(atlas.getTexture("font"), fontXML);
			TextField.registerBitmapFont(font, "play");
		}
		
		public static function get circleTexture():Texture {
			if (!_circleTexture) _circleTexture = atlas.getTexture("circle");
			return _circleTexture;
		}
		
		public static function get key():ByteArray {
			return new KeyClass() as ByteArray;
		}
		
		public static function get distriqrKey():String {
			return new DistriqtKeyClass();
		}
		
	}
}