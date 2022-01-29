package com.illuzor.cats {
	
	import com.illuzor.cats.constants.ItemType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite {
		
		/** список всех квадратов */
		private var itemList:Vector.<Item> = new Vector.<Item>();
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addButtons();
			addItems();
		}
		/** добавляем на экран кнопки меню */
		private function addButtons():void {
			// список определённых категорий
			var selectedCategories:Vector.<String> = new <String>[ItemType.BLUE, ItemType.GREEN, ItemType.RED, ItemType.YELLOW];
			for (var i:int = 0; i < 4; i++) {
				// задаём кнопке имя и категорию из списка
				var button:MenuButton = new MenuButton("Category " + String(i + 1), selectedCategories[i]);
				button.x = 10;
				button.y = (button.height + 10) * i + 10;
				addChild(button);
				button.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
		}
		/** добавляем на экран квадраты */
		private function addItems():void {
			
			var container:Sprite = new Sprite(); // контейнер для квадратов
			container.x = 100;
			container.y = 10;
			addChild(container);
			
			var row:uint;
			var col:uint;
			
			for (var i:int = 0; i < 16; i++) { // расставляем квадраты
				var item:Item = new Item();
				item.x = (60 * col);
				item.y = (60 * row);
				container.addChild(item);
				itemList.push(item); // добавляем квадрат в список
				
				// от балды задаём квадратам категории
				if (i >= 0 && i < 5) item.addCategory(ItemType.BLUE);
				if (i >= 4 && i < 10) item.addCategory(ItemType.GREEN);
				if (i > 8 && i < 15) item.addCategory(ItemType.RED);
				if(i == 2 || i == 3 || i == 4 || i == 6 || i == 13) item.addCategory(ItemType.YELLOW);
				
				if (col < 3) {
					col++;
				} else {
					col = 0;
					row++;
				}
			}
		}
		
		/** клик по кнопке меню */
		private function onButtonClick(e:MouseEvent):void {
			for (var i:int = 0; i < itemList.length; i++) { // проходим по списку квадратов
				// если квадрат содержит категорию, которая принадлежит нажатой кнопке...
				if (itemList[i].containsCategory(e.currentTarget.category)) { 
					itemList[i].colorize(e.currentTarget.category); // ... красим кнопку в соответствующий цвет
				} else { // если же нет, возвращаем стандартный цвет
					itemList[i].clear();
				}
			}
		}
		
	}
}