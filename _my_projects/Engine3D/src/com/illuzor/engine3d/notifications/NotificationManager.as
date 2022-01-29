package com.illuzor.engine3d.notifications {
	
	import com.illuzor.engine3d.notifications.LoaderWindow;
	import flash.display.Stage;
	
	/**
	 * Менеджер уведомлений. Управляет различными нотификациями.
	 * 
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class NotificationManager {
		/** @private контейнер для отображения окон. Главная сцена флешки */
		static private var container:Stage;
		/** @private массив нотификаций для очереди отображения */
		static private var notifications:Array;
		/** @private массив с лоадерами для удаления их со сцены */
		static private var loaders:Array;
		/** @private экземпляр окна прогресса загрузки для загрузки модели */
		static private var modelLoader:LoaderWindow;
		/** @private экземпляр окна прогресса загрузки для загрузки текстуры */
		static private var textureLoader:LoaderWindow;
		/** @private экземпляр сообщения об ожидании */
		static private var waitingMessage:WaitingMessageDesign;
		/**
		 * Инициализация. Задание контейнера, создание массивов.
		 * 
		 * @param	rootContainer контейнер для отображения окон. Главная сцена флешки
		 */
		static public function init(rootContainer:Stage):void {
			container = rootContainer;
			notifications = [];
			loaders = [];
		}
		/**
		 * Добавдение иформационного окна.
		 * 
		 * @param	type тип окна в виде строки.
		 */
		static public function addInfoWindow(type:String):void {
			
		}
		/**
		 * Добавление окна загрузки.
		 * 
		 * @param	type тип окна загрузки.
		 */
		static public function addLoaderWindow(type:String):void {
			if (type == WindowType.LOADING_MODEL) {
				modelLoader = new LoaderWindow("model loading");
				modelLoader.x = (container.stageWidth - modelLoader.width) / 2;
				modelLoader.y = (container.stageHeight - modelLoader.height) / 2  - 50;
				container.addChild(modelLoader);
				loaders.push(modelLoader);
			} else if (type == WindowType.LOADING_TEXTURE) {
				textureLoader = new LoaderWindow("texture loading");
				textureLoader.x = (container.stageWidth - textureLoader.width) / 2;
				textureLoader.y = (container.stageHeight - textureLoader.height) / 2  + 50;
				container.addChild(textureLoader);
				loaders.push(textureLoader);
			}
		}
		/**
		 * Обновление строки прогресса окна загрузки.
		 * 
		 * @param	type тип окна
		 * @param	value значение
		 */
		static public function updateLoaderWindow(type:String, value:Number):void {
			if (type == WindowType.LOADING_MODEL) {
				modelLoader.update(value);
			} else if (type == WindowType.LOADING_TEXTURE) {
				textureLoader.update(value);
			}
		}
		/**
		 * Удаление окон загрузки
		 */
		static public function removeLoaderWindow():void {
			for (var i:int = 0; i < loaders.length; i++) {
				container.removeChild(loaders[i]);
			}
			//while (container.numChildren) container.removeChildAt(0);
		}
		/**
		 * Добавление сообщаения об ожидании
		 * 
		 * @param	text
		 */
		static public function addWaitingMessage(text:String):void {
			waitingMessage = new WaitingMessageDesign();
			waitingMessage.tf.text = text;
			waitingMessage.tf.width = waitingMessage.tf.textWidth + 16;
			waitingMessage.tf.textColor = 0xFFFFFF;
			waitingMessage.x = (container.stageWidth - waitingMessage.width) / 2;
			waitingMessage.y = (container.stageHeight - waitingMessage.height) / 2;
			container.addChild(waitingMessage);
		}
		/**
		 * Удаление сообщаения об ожидании
		 */
		static public function removeWaitingMessage():void {
			container.removeChild(waitingMessage);
		}
		
	}
}