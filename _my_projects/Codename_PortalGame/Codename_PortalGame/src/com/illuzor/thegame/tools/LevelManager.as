package com.illuzor.thegame.tools {
	
	import by.blooddy.crypto.serialization.JSON;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com  //  illuzor@gmail.com
	 */
	
	public class LevelManager {
		
		[Embed(source = "../../../../../assets/levels.pgc", mimeType = "application/octet-stream")]
		private static const Levels:Class;
		
		private static var levels:Object;
		
		public static function getLevel(levelNum:uint):Object {
			if (levels == null) createLevelsObject()
			
			return levels.levels[levelNum];
		}
		
		public static function get levelsNum():uint {
			if (levels == null) createLevelsObject()
			return levels.levels.length;
		}
		
		private static function createLevelsObject():void {
			var levelsString:String = new Levels();
			levels = by.blooddy.crypto.serialization.JSON.decode(levelsString);
		}
		
	}
}