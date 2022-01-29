package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.constants.AtlasType;
	import com.illuzor.otherside.constants.LevelControllerType;
	import com.illuzor.otherside.constants.ScreenType;
	import com.illuzor.otherside.events.ResourceManagerEvent;
	import com.illuzor.otherside.events.ScreenEvent;
	import com.illuzor.otherside.graphics.screens.extra.LoadingScreen;
	import com.illuzor.otherside.graphics.screens.GameScreen;
	import com.illuzor.otherside.graphics.screens.MainMenu;
	import com.illuzor.otherside.graphics.screens.ScreenBase;
	import com.illuzor.otherside.interfaces.ILevelController;
	import com.illuzor.otherside.Settings;
	import com.illuzor.otherside.tools.ResourceManager;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class AppController {
		
		private static var _progress:Boolean;
		private static var container:Sprite;
		private static var screenType:uint;
		private static var screen:ScreenBase;
		private static var controllerType:String;
		private static var loadingScreen:LoadingScreen;
		
		public static function init(container:Sprite):void {
			AppController.container = container;
			container.addEventListener(ScreenEvent.CHANGE_SCREEN, onScreenEvent)
			container.addEventListener(ScreenEvent.ERROR, onScreenEvent)
		}
		
		private static function onScreenEvent(e:ScreenEvent):void {
			e.stopImmediatePropagation();
			switch (e.type) {
				case ScreenEvent.CHANGE_SCREEN:
					showScreen(ScreenType.GAME_SCREEN, { controllerType:LevelControllerType.LEVEL_CONTROLLER } );
				break;
				case ScreenEvent.ERROR:
					
				break;
			}
		}
		
		public static function start():void {
			showScreen(ScreenType.MAIN_MENU);
		}
		
		private static function showScreen(screenType:uint, data:Object = null):void {
			AppController.screenType = screenType;
			_progress = true;
			if (screen) {
				container.removeChild(screen);
				screen.dispose();
				loadingScreen = new LoadingScreen();
				container.addChild(loadingScreen);
			}
			
			switch (screenType) {
				case ScreenType.MAIN_MENU:
					ResourceManager.loadResources(Settings.langConfig == null, screenType);
				break;
				
				case ScreenType.GAME_SCREEN:
					AppController.controllerType = data.controllerType;
					ResourceManager.loadResources(Settings.langConfig == null, screenType, 1, 1);
				break;
			}
			ResourceManager.eventDispatcher.addEventListener(ResourceManagerEvent.RESOURCES_LOADED, onResourcesLoaded);
		}
		
		private static function onResourcesLoaded(e:ResourceManagerEvent):void {
			ResourceManager.eventDispatcher.removeEventListener(ResourceManagerEvent.RESOURCES_LOADED, onResourcesLoaded);
			switch (screenType) {
				case ScreenType.MAIN_MENU:
					screen = new  MainMenu(ResourceManager.assetManaget.getTextureAtlas(AtlasType.MENU_ATLAS));
					container.addChild(screen);
				break;
				case ScreenType.GAME_SCREEN:
					screen = new GameScreen(ResourceManager.assetManaget.getTextureAtlas(AtlasType.GAME_ATLAS), getController());
					container.addChild(screen);
					(screen as GameScreen).play();
				break;
			}
			if (loadingScreen) {
				container.removeChild(loadingScreen);
				loadingScreen.dispose();
				loadingScreen = null;
			}
		}
		
		private static function getController():ILevelController {
			var levelController:ILevelController;
			switch (controllerType) {
				case LevelControllerType.LEVEL_CONTROLLER:
					levelController = new LevelController(ResourceManager.assetManaget.getObject("levelConfig"), 
						ResourceManager.assetManaget.getTextureAtlas(AtlasType.GAME_ATLAS));
				break;
				case LevelControllerType.ENDLESS_CONTROLLER:
					
				break;
			}
			return levelController;
		}
		
		public static function get progress():Boolean {
			return _progress;
		}
		
	}
}