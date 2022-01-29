package com.illuzor.otherside.editor.tools {
	
	import com.illuzor.otherside.editor.constants.SettingsValue;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class StorageManager {
		
		private static var settings:Object = { };
		private static var settingsFile:File;
		
		public static function init():void {
			settingsFile = File.applicationStorageDirectory.resolvePath("app.settings");
			if (!settingsFile.exists) {
				LevelsStorage.initConfigs();
				settings[SettingsValue.FIRST_RUN] = true;
				writeSettings();
			} else {
				readSettings();
			}
		}
		
		private static function readSettings():void {
			var stream:FileStream = new FileStream();
			stream.open(settingsFile, FileMode.READ);
			settings = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();
			stream = null;
		}
		
		private static function writeSettings():void {
			var stream:FileStream = new FileStream();
			stream.open(settingsFile, FileMode.WRITE);
			stream.writeUTFBytes(JSON.stringify(settings));
			stream.close();
			stream = null;
		}
		
		public static function changeBoolParam(paramName:String, paramValue:Boolean):void {
			settings[paramName] = paramValue;
			writeSettings();
		}
		
		public static function getBoolParam(paramName:String):Boolean {
			return settings[paramName] as Boolean;
		}
		
	}
}