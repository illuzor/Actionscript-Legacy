package com.illuzor.airlab.screens.mainScreens {
	import com.illuzor.airlab.constants.Screens;
	
	import com.illuzor.airlab.constants.Screens;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class MainScreen extends Sprite {
		
		private const MAIN_MENU_SCREEN:String = "mainMenuScreen";
		private const SECTIONS_SCREEN:String = "sectionsScreen";
		private const CURRENT_DEMO_SCREEN:String = "currentDemoScreen";
		
		private var navigator:ScreenNavigator;
		
		public function MainScreen() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(stage);
			
			navigator = new ScreenNavigator();
			addChild(navigator);
			
			var mainMenu:ScreenNavigatorItem = new ScreenNavigatorItem(MainMenu, { sectionSelected:sectionSelected } );
			navigator.addScreen(MAIN_MENU_SCREEN, mainMenu);
			
			var sections:ScreenNavigatorItem = new ScreenNavigatorItem(Section, { goBack:MAIN_MENU_SCREEN, featSelected:demoSelected} );
			navigator.addScreen(SECTIONS_SCREEN, sections);
			
			var demo:ScreenNavigatorItem = new ScreenNavigatorItem(CurrentDemoScreen, { goBack:SECTIONS_SCREEN} );
			navigator.addScreen(CURRENT_DEMO_SCREEN, demo);
			
			navigator.showScreen(MAIN_MENU_SCREEN);
		}

		private function sectionSelected(e:Event, selectedItem:Object):void {
			Screens.currentScreenName = selectedItem.name;
			switch (selectedItem.name) {
				case Screens.AIR:
					Screens.currentSelectedScreen = Screens.airSections;
				break;
				case Screens.STAGE_3D:
					Screens.currentSelectedScreen = Screens.stage3dSections;
				break;
				case Screens.ANE:
					Screens.currentSelectedScreen = Screens.aneSections;
				break;
			}
			navigator.showScreen(SECTIONS_SCREEN);
		}
		
		private function demoSelected():void {
			
		}
		
	}
}