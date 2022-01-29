package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Основной класс
	 */
	
	public class Main extends Sprite {
		/** @private контейнер для тайлов */
		private var scene:Scene;
		/** @private менеджер импорта-экспорта высот */
		private var configManager:ConfigManager;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * @private создание экземпляра ConfigManager, создание scene
		 * @param	e
		 */
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			configManager = new ConfigManager();
			
			scene = new Scene();
			addChild(scene);
			scene.x = (stage.stageWidth - scene.width) >> 1;
			scene.y = 350;
			
			makeButtons();
		}
		
		/** @private создание кнопок */
		private function makeButtons():void {
			var buttonsContainer:Sprite = new Sprite();
			addChild(buttonsContainer);
			buttonsContainer.x = 20;
			
			var randomizeButton:TextButton = new TextButton("Randomize");
			buttonsContainer.addChild(randomizeButton);
			
			var resetButton:TextButton = new TextButton("Reset");
			buttonsContainer.addChild(resetButton);
			resetButton.y = 30;
			
			var preset1Button:TextButton = new TextButton("Preset 1");
			buttonsContainer.addChild(preset1Button);
			preset1Button.y = 70;
			
			var preset2Button:TextButton = new TextButton("Preset 2");
			buttonsContainer.addChild(preset2Button);
			preset2Button.y = 100;
			
			var preset3Button:TextButton = new TextButton("Preset 3");
			buttonsContainer.addChild(preset3Button);
			preset3Button.y = 130;
			
			var importButton:TextButton = new TextButton("Import config");
			buttonsContainer.addChild(importButton);
			importButton.y = 170;
			
			var exportButton:TextButton = new TextButton("Export config");
			buttonsContainer.addChild(exportButton);
			exportButton.y = 200;
			
			buttonsContainer.y = (stage.stageHeight - buttonsContainer.height) >> 1;
			buttonsContainer.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		/**
		 * @private клик по кнопке
		 * @param	e событие клика
		 */
		private function onButtonClick(e:MouseEvent):void {
			switch (e.target.text) {
				case "Randomize":
					randomizeHeights();
				break;
				case "Reset":
					scene.reset();
				break;
				case "Preset 1":
					scene.heights = Presets.preset1;
				break;
				case "Preset 2":
					scene.heights = Presets.preset2;
				break;
				case "Preset 3":
					scene.heights = Presets.preset3;
				break;
				case "Import config":
					configManager.openConfig();
					configManager.addEventListener(Event.COMPLETE, onConfigManagerEvent);
					configManager.addEventListener(Event.CANCEL, onConfigManagerEvent);
				break;
				case "Export config":
					configManager.saveConfig(scene.heights);
				break;
			}
		}
		
		/**
		 * @private Обработка события от configManager
		 * @param	e
		 */
		private function onConfigManagerEvent(e:Event):void {
			configManager.removeEventListener(Event.COMPLETE, onConfigManagerEvent);
			configManager.removeEventListener(Event.CANCEL, onConfigManagerEvent);
			if (e.type == Event.COMPLETE)
				scene.heights = configManager.openedHeights;
		}
		
		/** @private создание массива со случайными значениями и применение его к scene */
		private function randomizeHeights():void {
			var randomValues:Array = new Array();
			for (var i:int = 0; i < scene.totalTiles; i++) {
				randomValues.push(int(Math.random() * 300 - 150));
			}
			scene.heights = randomValues;
		}
		
	}
}