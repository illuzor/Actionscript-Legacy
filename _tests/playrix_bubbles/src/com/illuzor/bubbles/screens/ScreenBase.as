package com.illuzor.bubbles.screens {
	
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Базовый "абстрактный" класс для экранов
	 */
	
	public class ScreenBase extends Sprite {
		
		/** @private ширина сцены */
		private var _stageWidth:uint;
		/** @private высота сцены */
		private var _stageHeight:uint;
		
		/** В конструкторе слушаем добавление на сцену */
		public function ScreenBase() {
			Mouse.cursor = MouseCursor.AUTO; // какой-то баг старлинга. После нажатия на кнопку иногда остаётся handCursor.
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			_stageWidth = stage.stageWidth; // чтоб не обращаться к свойствам сцены постоянно, 
			_stageHeight = stage.stageHeight; // сохраняем значения ширины и высоты
			start();
		}
		
		/** 
		 * Имитация абстрактного класса.
		 * Метод start запускается после добавления на сцену.
		 * Обязательно должен быть переопределён.
		 * */
		protected function start():void {
			throw new Error("start() method must be overrided in abstract class ScreenBase");
		}
		
		protected function get stageWidth():uint {
			return _stageWidth;
		}
		
		protected function get stageHeight():uint {
			return _stageHeight;
		}
		
	}
}