package com.illuzor.circles.ui.screens {
	
	import com.greensock.TweenLite;
	import com.illuzor.circles.constants.MenuType;
	import com.illuzor.circles.events.PlayEvent;
	import com.illuzor.circles.events.ScreenEvent;
	import com.illuzor.circles.Settings;
	import com.illuzor.circles.tools.Assets;
	import com.illuzor.circles.tools.KeyboardManager;
	import com.illuzor.circles.tools.PlayManager;
	import com.illuzor.circles.ui.screens.menus.AboutMenu;
	import com.illuzor.circles.ui.screens.menus.GameModesMenu;
	import com.illuzor.circles.ui.screens.menus.SettingsMenu;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MainMenu extends Sprite {
		
		private var playButton:Button;
		private var background:Background;
		private var progress:Boolean;
		private var mainContainer:Sprite;
		private var stageWidth:uint;
		private var stageHeight:uint;
		private var settingsButton:Button;
		private var aboutButton:Button;
		private var menuToShow:String;
		private var menuScreen:Sprite;
		private var gplusButton:Button;
		
		public function MainMenu() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			background = new Background();
			addChild(background);
			
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			mainContainer = new Sprite();
			addChild(mainContainer);
			
			var logo:Image = new Image(Assets.atlas.getTexture("logo"));
			mainContainer.addChild(logo);
			if (logo.width > stageWidth * .65) {
				logo.width = stageWidth * .65;
				logo.scaleY = logo.scaleX;
			}
			
			logo.x = (stageWidth - logo.width) >> 1;
			logo.y = (stageHeight >> 2) - (logo.height >> 1);
			
			playButton = new Button(Assets.atlas.getTexture("play_button"));
			mainContainer.addChild(playButton);
			setButtonSize(playButton);
			playButton.x = (stageWidth - playButton.width) / 2;
			playButton.y = (stageHeight) / 2;
			
			settingsButton = new Button(Assets.atlas.getTexture("settings_button"));
			mainContainer.addChild(settingsButton);
			setButtonSize(settingsButton);
			settingsButton.x = settingsButton.width >> 1;
			settingsButton.y = stageHeight - settingsButton.height * 1.5;
			
			aboutButton = new Button(Assets.atlas.getTexture("about_button"));
			mainContainer.addChild(aboutButton);
			setButtonSize(aboutButton);
			aboutButton.x = stageWidth - aboutButton.width * 1.5;
			aboutButton.y = stageHeight - aboutButton.height * 1.5;
			
			if (Settings.isGoogle) {
				if (!PlayManager.signedIn) {
					PlayManager.dispatcher.addEventListener(PlayEvent.SIGN_IN_SUCCESS, inPlayEvent);
					PlayManager.dispatcher.addEventListener(PlayEvent.SIGN_IN_FAIL, inPlayEvent);
					PlayManager.init();
				} else {
					createGplusButton();
				}
			}
			
			activatePlayListeners()
		}
		
		private function inPlayEvent(e:PlayEvent):void {
			PlayManager.dispatcher.removeEventListener(PlayEvent.SIGN_IN_SUCCESS, inPlayEvent);
			PlayManager.dispatcher.removeEventListener(PlayEvent.SIGN_IN_FAIL, inPlayEvent);
			if (e.type == PlayEvent.SIGN_IN_SUCCESS) {
				createGplusButton();
			} 
		}
		
		private function createGplusButton():void {
			gplusButton = new Button(Assets.atlas.getTexture("gplus_button"));
			gplusButton.alpha = 0;
			mainContainer.addChild(gplusButton);
			setButtonSize(gplusButton);
			gplusButton.x = (stageWidth - gplusButton.width) >> 1;
			gplusButton.y = stageHeight - gplusButton.height * 1.5;
			gplusButton.addEventListener(Event.TRIGGERED, onButtonEvent);
			TweenLite.to(gplusButton, .5, { alpha:1 } );
		}
		
		[Inline]
		private final function setButtonSize(button:Button):void {
			button.width = button.height = stageWidth / 5;
		}
		
		private function onButtonEvent(e:Event):void {
			if (!progress) {
				switch (e.target) {
					case playButton:
						menuToShow = MenuType.GAME_MODES;
						progress = true;
						TweenLite.to(mainContainer, .25, { alpha:0, onComplete:showMenu } );
					break;
					case settingsButton:
						menuToShow = MenuType.SETTINGS;
						progress = true;
						TweenLite.to(mainContainer, .25, { alpha:0, onComplete:showMenu } );
					break;
					case aboutButton:
						menuToShow = MenuType.ABOUT;
						progress = true;
						TweenLite.to(mainContainer, .25, { alpha:0, onComplete:showMenu } );
					break;
					
					case gplusButton:
						PlayManager.showLeaderboards();
					break;
				}
			}
		}
		
		private function showMenu():void {
			deactivatePlayListeners();
			
			switch (menuToShow) {
				case menuToShow = MenuType.GAME_MODES:
					menuScreen = new GameModesMenu();
				break;
				
				case menuToShow = MenuType.SETTINGS:
					menuScreen = new SettingsMenu();
				break;
				
				case menuToShow = MenuType.ABOUT:
					menuScreen = new AboutMenu();
				break;
			}
			
			menuScreen.alpha = 0;
			TweenLite.to(menuScreen, .32, { alpha:1 } );
			addChild(menuScreen);
			progress = false;
			KeyboardManager.setFunction(onBack);
			menuScreen.addEventListener(ScreenEvent.GOTO_MAIN, onBack);
		}
		
		private function onBack(e:ScreenEvent = null):void {
			if (e) e.stopImmediatePropagation();
			KeyboardManager.removeFunc();
			progress = true;
			TweenLite.to(menuScreen, .3, { alpha:0, onComplete:gotoMain } );
		}
		
		private function gotoMain():void {
			progress = false;
			removeChild(menuScreen);
			menuScreen.dispose();
			activatePlayListeners();
			TweenLite.to(mainContainer, .25, { alpha:1 } );
		}
		
		private function activatePlayListeners():void {
			playButton.addEventListener(Event.TRIGGERED, onButtonEvent);
			settingsButton.addEventListener(Event.TRIGGERED, onButtonEvent);
			aboutButton.addEventListener(Event.TRIGGERED, onButtonEvent);
			if(gplusButton)gplusButton.addEventListener(Event.TRIGGERED, onButtonEvent);
		}
		
		private function deactivatePlayListeners():void {
			playButton.removeEventListener(Event.TRIGGERED, onButtonEvent);
			settingsButton.removeEventListener(Event.TRIGGERED, onButtonEvent);
			aboutButton.removeEventListener(Event.TRIGGERED, onButtonEvent);
			if(gplusButton)gplusButton.removeEventListener(Event.TRIGGERED, onButtonEvent);
		}

		private function disableProgress():void {
			progress = false;
		}
		
		override public function dispose():void {
			background.dispose();
		}
		
	}
}