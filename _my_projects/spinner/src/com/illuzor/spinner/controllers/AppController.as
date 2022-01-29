package com.illuzor.spinner.controllers {
	
	import com.illuzor.spinner.constants.HideActionType;
	import com.illuzor.spinner.constants.ScreenType;
	import com.illuzor.spinner.constants.SubscreenType;
	import com.illuzor.spinner.events.ScreenEvent;
	import com.illuzor.spinner.screens.GameScreen;
	import com.illuzor.spinner.screens.MainMenu;
	import com.illuzor.spinner.screens.ScreenBase;
	import com.illuzor.spinner.screens.ShapeSelectionScreen;
	import com.illuzor.spinner.screens.subscreens.ReplayScreen;
	import com.illuzor.spinner.Settings;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class AppController {
		
		public static var assetManager:AssetManager;
		
		private static var container:Sprite;
		private static var screen:ScreenBase;
		private static var subscreen:ScreenBase;
		
		public static function init(container:Sprite):void {
			AppController.container = container;
			container.addEventListener(ScreenEvent.CHANGE_SCREEN, onChangeScreen);
			container.addEventListener(ScreenEvent.SHOW_SUBSCREEN, onShowSubscreen);
		}
		
		public static function start():void {
			assetManager = new AssetManager();
			assetManager.enqueue("langs/" + Settings.lang + ".lang");
			assetManager.enqueue("graphics/atlas1.atf", "graphics/atlas1.xml");
			assetManager.enqueue("configs/game_font.fnt");
			assetManager.loadQueue(onLoadProgress);
		}
		
		private static function onLoadProgress(aspect:Number):void {
			if (aspect >= 1) {
				Settings.langObj = assetManager.getObject(Settings.lang);
				showScreen(ScreenType.MAIN_MENU);
			}
		}
		
		private static function onChangeScreen(e:ScreenEvent):void {
			if (screen) {
				container.removeChild(screen);
				screen.dispose();
			}
			showScreen(e.screenType, e.data);
		}
		
		private static function showScreen(screenType:uint, data:Object = null):void {
			if (screen) {
				container.removeChild(screen);
				screen.dispose();
			}
			switch (screenType) {
				case ScreenType.MAIN_MENU:
					screen = new MainMenu();
				break;
				
				case ScreenType.GAME_SELECTION_MENU:
				
				break;
				
				case ScreenType.SHAPE_SELECTION_MENU:
					screen = new ShapeSelectionScreen();
				break;
				
				case ScreenType.GAME_SCREEN:
					screen = new GameScreen(data.shape, data.diff);
				break;
			}
			container.addChild(screen);
		}
		
		private static function onShowSubscreen(e:ScreenEvent):void {
			if(!subscreen){
				switch (e.screenType) {
					case SubscreenType.MAIN_ABOUT:
						
					break;
					case SubscreenType.MAIN_GOOGLE_PLAY:
						
					break;
					case SubscreenType.MAIN_SETTINGS:
						
					break;
					case SubscreenType.GAME_REPLAY:
						subscreen = new ReplayScreen();
					break;
				}
				container.addChild(subscreen);
				subscreen.addEventListener(ScreenEvent.SCREEN_HIDED, onSubscreenHided);
			}
		}
		
		private static function onSubscreenHided(e:ScreenEvent):void {
			switch (e.data.hide) {
				case HideActionType.REPLAY:
					(screen as GameScreen).replay();
				break;
				default:
			}
			subscreen.removeEventListener(ScreenEvent.SCREEN_HIDED, onSubscreenHided);
			container.removeChild(subscreen);
			subscreen.dispose();
			subscreen = null;
		}
		
	}
}