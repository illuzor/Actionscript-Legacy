package com.illuzor.otherside.tools {
	
	import com.illuzor.otherside.constants.AtlasType;
	import com.illuzor.otherside.constants.ScreenType;
	import com.illuzor.otherside.events.ResourceManagerEvent;
	import com.illuzor.otherside.Settings;
	import starling.events.EventDispatcher;
	import starling.text.BitmapFont;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ResourceManager {
		
		public static var assetManaget:AssetManager;
		
		private static var _eventDispatcher:EventDispatcher = new EventDispatcher();
		private static var _font:BitmapFont;
		private static var loadFont:Boolean;
		//private static var fontXML:XML;
		private static var screenType:uint;
		private static var levelNum:uint;
		
		public static function loadResources(loadLang:Boolean, screenType:uint, zoneNum:uint = 0, levelNum:uint = 0):void {
			ResourceManager.levelNum = levelNum;
			ResourceManager.screenType = screenType;
			ResourceManager.loadFont = loadFont;
			if (assetManaget) {
				assetManaget.dispose();
			} else {
				assetManaget = new AssetManager();
				//assetManaget.scaleFactor = 1 + ResizeManager.scale;
			}
			if (loadLang) assetManaget.enqueueWithName("langs/" + Settings.lang + ".lang");
			switch (screenType) {
				case ScreenType.MAIN_MENU:
					assetManaget.enqueue("graphics/menuAtlas.xml", "graphics/menuAtlas.atf");
				break;
				case ScreenType.GAME_SCREEN:
					assetManaget.enqueue("graphics/gameAtlas.xml", "graphics/gameAtlas.atf");
					assetManaget.enqueueWithName("levels/zone" + String(zoneNum) + "level" + String(levelNum) + ".osl", "levelConfig");
				break;
			}
			assetManaget.enqueueWithName("graphics/thin_pixel_font.xml", "pixel_fon");
			assetManaget.loadQueue(loadingProgress);
		}
		
		private static function loadingProgress(aspect:Number):void {
			if (aspect == 1) {
				Settings.langConfig = assetManaget.getObject(Settings.lang);
				_eventDispatcher.dispatchEvent(new ResourceManagerEvent(ResourceManagerEvent.RESOURCES_LOADED));
			}
		}
		
		public static function get eventDispatcher():EventDispatcher {
			return _eventDispatcher;
		}
		
		public static function get font():BitmapFont {
			return _font;
		}
		
	}
}