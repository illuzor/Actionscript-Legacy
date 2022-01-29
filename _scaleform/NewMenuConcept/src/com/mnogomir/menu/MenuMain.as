package com.mnogomir.menu {
	
	import com.mnogomir.menu.elements.MainButton;
	import com.mnogomir.menu.elements.MenuObject;
	import flash.display.Sprite;
	import scaleform.clik.controls.Button;
	import scaleform.clik.core.UIComponent;
	import scaleform.gfx.Extensions;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	public class MenuMain extends Sprite {
		
		private var menuObject:MenuObject;
		private var menuToggle:Boolean;
		private var objects:Vector.<Object> = new Vector.<Object>();
		
		public function MenuMain() {
			
			Extensions.enabled = true;
			
			var mainButton:Button = new MainButton();
			mainButton.buttonMode = true;
			addChild(mainButton);
			
			menuObject = new MenuObject();
			menuObject.x = 80;
			menuObject.y = 100;
			//menuObject.hide.addEventListener(MouseEvent.CLICK, onMenuToggle);
			Controller.menuObject = menuObject;
			
			
			
			mainButton.addEventListener(MouseEvent.CLICK, onMenuToggle);
			
			pushValue(["Растительность", "Деревья"], "Дерево 1", 0);
			pushValue(["Растительность", "Деревья"], "Дерево 2", 0);
			pushValue(["Растительность", "Деревья"], "Дерево 3", 0);
			
			pushValue(["Растительность", "Кусты"], "Куст 1", 0);
			pushValue(["Растительность", "Кусты"], "Куст 2", 0);
			pushValue(["Растительность", "Кусты"], "Куст 3", 0);
			pushValue(["Растительность", "Кусты"], "Куст 4", 0);
			pushValue(["Растительность", "Кусты"], "Куст 5", 0);
			pushValue(["Растительность", "Кусты"], "Куст 6", 0);
			pushValue(["Растительность", "Кусты"], "Куст 7", 0);
			pushValue(["Растительность", "Кусты"], "Куст 8", 0);
			pushValue(["Растительность", "Кусты"], "Куст 9", 0);
			pushValue(["Растительность", "Кусты"], "Куст 10", 0);
			pushValue(["Растительность", "Кусты"], "Куст 11", 0);
			pushValue(["Растительность", "Кусты"], "Куст 12", 0);
			pushValue(["Растительность", "Кусты"], "Куст 13", 0);
			pushValue(["Растительность", "Кусты"], "Куст 1", 0);
			pushValue(["Растительность", "Кусты"], "Куст 2", 0);
			pushValue(["Растительность", "Кусты"], "Куст 3", 0);
			pushValue(["Растительность", "Кусты"], "Куст 4", 0);
			pushValue(["Растительность", "Кусты"], "Куст 5", 0);
			pushValue(["Растительность", "Кусты"], "Куст 6", 0);
			pushValue(["Растительность", "Кусты"], "Куст 7", 0);
			pushValue(["Растительность", "Кусты"], "Куст 8", 0);
			pushValue(["Растительность", "Кусты"], "Куст 9", 0);
			pushValue(["Растительность", "Кусты"], "Куст 10", 0);
			pushValue(["Растительность", "Кусты"], "Куст 11", 0);
			pushValue(["Растительность", "Кусты"], "Куст 12", 0);
			pushValue(["Растительность", "Кусты"], "Куст 13", 0);
			
			pushValue(["Растительность", "Цветы"], "Цветок 1", 0);
			pushValue(["Растительность", "Цветы"], "Цветок 2", 0);
			pushValue(["Растительность", "Цветы"], "Цветок 3", 0);
			pushValue(["Растительность", "Цветы"], "Цветок 4", 0);
			pushValue(["Растительность", "Цветы"], "Цветок 5", 0);
			
			pushValue(["Интерьер", "Столы"], "Стол 1", 0);
			pushValue(["Интерьер", "Столы"], "Стол 2", 0);
			pushValue(["Интерьер", "Столы"], "Стол 3", 0);
			pushValue(["Интерьер", "Столы"], "Стол 4", 0);
			
			pushValue(["Интерьер", "Кресла"], "Кресло 1", 0);
			pushValue(["Интерьер", "Кресла"], "Кресло 2", 0);
			pushValue(["Интерьер", "Кресла"], "Кресло 3", 0);
			pushValue(["Интерьер", "Кресла"], "Кресло 5", 0);
			
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 1"], "Мебель 1", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 1"], "Мебель 2", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 1"], "Мебель 3", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 1"], "Мебель 4", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 1"], "Мебель 5", 0);
			
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 1", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 2", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 3", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 4", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 5", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 6", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 2"], "Мебель ф2 6", 0);
			
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 1", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 2", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 3", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 4", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 5", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 6", 0);
			pushValue(["Интерьер", "Мебель кухонная", "Мебель от фирмы 3"], "Мебель ф3 6", 0);
			
			pushValue(["Экстерьер", "Беседки"], "Беседка большая", 0);
			pushValue(["Экстерьер", "Беседки"], "Беседка маленькая", 0);
			pushValue(["Экстерьер", "Беседки"], "Беседка гигантская", 0);
			
			pushValue(["Экстерьер", "Фонари"], "Фонарь 1", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 2", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 3", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 4", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 5", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 6", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 7", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 8", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 9", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 10", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 11", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 12", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 13", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 14", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 15", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 16", 0);
			pushValue(["Экстерьер", "Фонари"], "Фонарь 17", 0);
			
			pushValue(["Экстерьер", "Заборы"], "Забор 1", 0);
			pushValue(["Экстерьер", "Заборы"], "Забор 2", 0);
			
			pushValue(["Экстерьер", "Статуи"], "Статуя 1", 0);
			pushValue(["Экстерьер", "Статуи"], "Статуя 2", 0);
			pushValue(["Экстерьер", "Статуи"], "Статуя 3", 0);
			
			for (var i:int = 0; i < objects.length ; i++) {
				if (i < 3) {
					var string:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent et tempus nulla. Praesent id volutpat sapien. Sed lorem dolor, rhoncus ut fringilla a, eleifend consectetur eros. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque ac lectus metus. Nullam massa nisi, cursus et sagittis sed, viverra eleifend erat. Proin ornare laoreet lorem in imperdiet. Morbi auctor orci quis purus varius rutrum. Donec consectetur luctus mauris. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus mattis aliquam libero non interdum. Duis auctor blandit nulla at scelerisque. In sed sodales ligula. Curabitur hendrerit dolor sed nulla tempor rutrum a malesuada lectus. Nullam mollis consequat nisl, eu blandit metus fringilla gravida. Fusce vel risus et turpis porttitor mattis. Praesent rutrum laoreet massa vitae tempus. Donec sed massa eu nisi pulvinar ornare vel sed tellus. Proin et nisl eget velit tristique fringilla. Integer rhoncus velit id libero fringilla facilisis. Donec eu turpis vestibulum enim volutpat consectetur vitae et tellus. Cras mi odio, accumsan eu elementum eu, semper vitae risus. Phasellus ut neque nisl, eu commodo lectus. Duis gravida varius lacinia. Sed sit amet ullamcorper mi. Vivamus condimentum magna sed tortor ullamcorper mollis. Etiam imperdiet, orci at commodo interdum, est nisi hendrerit lectus, at pharetra felis nisl id lorem."
					Controller.push(objects[i].path, objects[i].lbl, objects[i].dat, string);
				} else {
					Controller.push(objects[i].path, objects[i].lbl, objects[i].dat, objects[i].info);
				}
				
				//trace(objects[i].info)
			}
			
			
			/*Controller.push(["кресла", "большие"], "кресло б 1", 1.1);
			Controller.push(["кресла", "большие"], "кресло б 1", 1.2);
			Controller.push(["кресла", "большие"], "кресло б 2", 1.3);
			
			Controller.push(["кресла", "средние", "полусредние"], "кресло пc 1", 2.1);
			Controller.push(["кресла", "средние", "полусредние"], "кресло пc 2", 2.2);
			
			Controller.push(["кресла", "средние", "совсем средние"], "кресло пc 1", 3.1);
			Controller.push(["кресла", "средние", "совсем средние"], "кресло пc 2", 3.2);*/
			//Controller.menuObject = 
			
			//Controller.showMenu();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onMenuToggle(e:MouseEvent):void {
			menuToggle = !menuToggle;
			if (menuToggle) {
				//if (menuObject == null) {
					
					//menuObject.y = (stage.stageHeight - menuObject.height) / 2;
				//}
				addChild(menuObject)
			} else {
				removeChild(menuObject);
			}
			//trace(menuToggle);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		public function pushValue(path:Array, lbl:String, dat:Number):void {
			objects.push( { path:path, lbl:lbl, dat:dat, info:"Информация об '" + lbl + "'" } );
			//Controller.push(path, lbl, dat);
		}
		
	}
}