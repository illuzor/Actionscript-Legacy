package com.illuzor.circles {
	
	import com.greensock.TweenLite;
	import com.illuzor.circles.constants.ScreenType;
	import com.illuzor.circles.events.ResourceLoaderEvent;
	import com.illuzor.circles.events.ScreenEvent;
	import com.illuzor.circles.tools.Assets;
	import com.illuzor.circles.tools.ResourceLoader;
	import com.illuzor.circles.tools.StorageManager;
	import com.illuzor.circles.ui.screens.ChangingCircle;
	import com.illuzor.circles.ui.screens.GameScreen;
	import com.illuzor.circles.ui.screens.MainMenu;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Game extends Sprite {
		
		private var progress:Boolean = false;
		private var changingCircle:ChangingCircle;
		private var screen:Sprite;
		private var gameTypeToOpen:String;
		
		public function Game() {
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:starling.events.Event):void {
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded);
			var loader:ResourceLoader = new ResourceLoader();
			loader.addEventListener(ResourceLoaderEvent.RESOURCES_LOADED, onLoaded);	
		}
		
		private function onLoaded(e:ResourceLoaderEvent):void {
			e.target.removeEventListener(ResourceLoaderEvent.RESOURCES_LOADED, onLoaded);
			Assets.atlas = e.target.atlas;
			Assets.setFont(e.target.fontXML);
			Settings.dispatch();
			setTimeout(delayedStart, 600);
			StorageManager.increaseRuns();
			
			/*AdsManager.init();
			if(StorageManager.getInt("runs") > 3)
				AdsManager.showAds();*/
		}
		
		private function delayedStart():void {
			showScreen(ScreenType.MAIN_MENU);
			addEventListener(ScreenEvent.CHANGE_SCREEN, onChangeScreen);
		}
		
		private function onChangeScreen(e:ScreenEvent):void {
			e.stopImmediatePropagation();
			if(!progress){
				switch (e.screenType) {
					case ScreenType.GAME_SCREEN:
						//AdsManager.hideAds();
						gameTypeToOpen = e.gameType;
						progress = true;
						changingCircle = new ChangingCircle();
						addChild(changingCircle);
						changingCircle.x = stage.stageWidth >> 1;
						changingCircle.y = stage.stageHeight >> 1;
						var radius:uint = ((Math.sqrt(Math.pow(stage.stageWidth, 2) + Math.pow(stage.stageHeight, 2))) >> 1) + 2;
						TweenLite.to(changingCircle, 1, { size:radius, onComplete:showGameScreen } );
					break;
					
					case ScreenType.MAIN_MENU:
						TweenLite.to(screen, .3, { alpha:0, onComplete:showMenu } );
					break;
				}
			}
		}
		
		private function showMenu():void {
			removeChild(screen)
			screen.dispose();
			showScreen(ScreenType.MAIN_MENU);
		}
		
		private function showGameScreen():void {
			screen.dispose();
			removeChild(screen);
			removeChild(changingCircle);
			showScreen(ScreenType.GAME_SCREEN);
		}
		
		private function showScreen(screenType:uint):void {
			switch (screenType) {
				case ScreenType.MAIN_MENU:
					screen = new MainMenu();
					addChild(screen);
				break;
				case ScreenType.GAME_SCREEN:
					screen = new GameScreen(gameTypeToOpen);
					addChild(screen);
				break;
			}
			progress = false;
		}
		
	}
}