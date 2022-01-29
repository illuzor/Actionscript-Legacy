package  {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * класс для импорта-экспорта набора высот
	 */
	
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "cancel", type = "flash.events.Event")]
	
	public class ConfigManager extends EventDispatcher {
		/** @private массив точек, считанный из внешнего файла */
		private var _openedHeights:Array;
		/** @private FileReference для открытия и сохранения файлов */
		private var fileReference:FileReference;
		
		/**
		 * Сохранение массива точек в файл
		 * @param	config массив точек
		 */
		public function saveConfig(config:Array):void {
			var configString:String = config.join(",");
			var configBytes:ByteArray = new ByteArray();
			configBytes.writeUTFBytes(configString);
			fileReference = new FileReference();
			fileReference.save(configBytes, "heights.txt");
		}
		
		/** открытие диалога для выбора файла */
		public function openConfig():void {
			fileReference = new FileReference();
			fileReference.browse();
			fileReference.addEventListener(Event.SELECT, onBrowse);
			fileReference.addEventListener(Event.CANCEL, onBrowse);
		}
		
		/**
		 * @private если файл открыт, загружаем его байты, если нет - диспатчим событие отмены
		 * @param	e Event.SELECT или Event.CANCEL
		 */
		private function onBrowse(e:Event):void {
			if (e.type == Event.SELECT) {
				fileReference.removeEventListener(Event.SELECT, onBrowse);
				fileReference.load();
				fileReference.addEventListener(Event.COMPLETE, onLoaded);
			} else if (Event.CANCEL) {
				dispatchEvent(new Event(Event.CANCEL));
			}
		}
		
		/**
		 * @private когда байты загружены, переводим их в строку, а строку в массив высот, диспатчим событие Event.COMPLETE
		 * @param	e событие окончания загрузки байтов
		 */
		private function onLoaded(e:Event):void {
			var bytes:ByteArray = fileReference.data;
			var string:String = bytes.readUTFBytes(bytes.length);
			_openedHeights = string.split(",");
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/** массив точек, считанный из внешнего файла */
		public function get openedHeights():Array {
			return _openedHeights;
		}
		
	}
}