package com.illuzor.bubbles {
	
	import com.greensock.TweenLite;
	import com.illuzor.bubbles.constants.ScreenType;
	import com.illuzor.bubbles.events.ScreenEvent;
	import com.illuzor.bubbles.screens.GameScreen;
	import com.illuzor.bubbles.screens.MainMenu;
	import com.illuzor.bubbles.screens.ScreenBase;
	import com.illuzor.bubbles.tools.ResourceManager;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Точка входа в игру
	 */
	
	public class Game extends Sprite {
		
		private var currentScreen:ScreenBase;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			ResourceManager.load(); // грузим ресурсы
			ResourceManager.dispatcher.addEventListener(Event.COMPLETE, onLoaded); // слушаем окончания загрузки
		} 
		
		/**
		 * @private обработчик окончания загрузки
		 * 
		 * @param	e событие окончания загрузки
		 */
		private function onLoaded(e:Event):void {
			showScreen(ScreenType.MAIN_MENU); // показываем главное меню
			addEventListener(ScreenEvent.CHANGE_SCREEN, onScreenEvent); // слушатель на изменение экрана
		}
		
		/**
		 * @private прячет старый экран
		 * 
		 * @param	e событие изменения экрана
		 */
		private function onScreenEvent(e:ScreenEvent):void {
			e.stopImmediatePropagation();
			TweenLite.to(currentScreen,  1, { alpha:0, onComplete:showScreen, onCompleteParams:[e.screenType] } );
		}
		
		/**
		 * @private создаёт новый экран и добавляет на сцену
		 * 
		 * @param	screenType тип экрана, который нужно отобразить
		 */
		private function showScreen(screenType:uint):void {
			if (currentScreen) {
				removeChild(currentScreen);
				currentScreen.dispose();
			}
			switch (screenType) {
				case ScreenType.MAIN_MENU:
					currentScreen = new MainMenu();
				break;
				case ScreenType.GAME_SCREEN:
					currentScreen = new GameScreen();
				break;
			}
			addChild(currentScreen);
		}
		
	}
}