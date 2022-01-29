package com.illuzor.thegame.editor {
	
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.illuzor.thegame.editor.elements.Item;
	import com.illuzor.thegame.editor.events.EditorEvent;
	import com.illuzor.thegame.editor.notifications.AskWindow;
	import com.illuzor.thegame.editor.panels.SelectedItemPanel;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.illuzor.thegame.editor.tools.StorageManager;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	[Event(name = "playLevel", type = "com.illuzor.thegame.editor.events.EditorEvent")]
	[Event(name = "mainMenu", type = "com.illuzor.thegame.editor.events.EditorEvent")]
	
	public class Editor extends Sprite {
		
		private var itemValues:Vector.<String> = new <String>[
		"StripedFloor", 
		"BrickWall",
		"Beton"
		];
		
		private var editorContainer:Sprite;
		private var itemSelected:Boolean;
		private var currentItem:Item;
		private var hero:Item;
		private var patternsContainer:Sprite;
		private var itemCandidate:Item;
		private var itemPanel:SelectedItemPanel;
		private var levelName:String;
		private var _levelData:Object;
		private var levelLabel:Label;
		private var playLevelButton:PushButton;
		private var saveCurrentLevel:PushButton;
		private var backToMainMenu:PushButton;
		
		public function Editor(levelName:String) {
			this.levelName = levelName;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var background:Shape = new Shape();
			background.graphics.beginFill(0xC0C0C0);
			background.graphics.drawRect(0,0, 800, 600);
			background.graphics.endFill();
			addChild(background);
			
			editorContainer = new Sprite();
			addChild(editorContainer);
			
			patternsContainer = new Sprite();
			patternsContainer.x = 810;
			addChild(patternsContainer);
			
			itemPanel = new SelectedItemPanel();
			itemPanel.y = 600;
			itemPanel.applyCoordinatesBut.addEventListener(MouseEvent.CLICK, onSetCoordinatesNumber);
			itemPanel.removeButton.addEventListener(MouseEvent.CLICK, onRemoveItem);
			
			levelLabel = new Label(this, 810, 610, levelName);
			levelLabel.width = stage.stageWidth - levelLabel.x - 10;
			
			playLevelButton = new PushButton(this, 810, 640, "TEST LEVEL");
			playLevelButton.addEventListener(MouseEvent.CLICK, playLevel);
			saveCurrentLevel = new PushButton(this, 810, 670, "SAVE LEVEL");
			saveCurrentLevel.addEventListener(MouseEvent.CLICK, saveLevel);
			backToMainMenu = new PushButton(this, 810, 700, "MAIN MENU");
			backToMainMenu.addEventListener(MouseEvent.CLICK, gotoMainMenu);
			
			for (var i:int = 0; i < itemValues.length; i++) {
				var listItem:Item = new Item(itemValues[i]);
				if (i > 0) listItem.y = patternsContainer.height + 10;
				patternsContainer.addChild(listItem);
				listItem.addEventListener(MouseEvent.MOUSE_DOWN, onListItemMouseDown);
			}
			
			hero = new Item("Hero");
			hero.x = (800 - hero.width) / 2;
			hero.y = (600 - hero.height) / 2;
			hero.addEventListener(MouseEvent.MOUSE_DOWN, editorItemMouseDown);
			addChild(hero);
			
			var vLine:Shape = new Shape();
			vLine.graphics.beginFill(0x003D59);
			vLine.graphics.drawRect(800, 0, 1, stage.stageHeight);
			vLine.graphics.endFill();
			addChild(vLine);
			
			var hLine:Shape = new Shape();
			hLine.graphics.beginFill(0x003D59);
			hLine.graphics.drawRect(0, 600, stage.stageWidth, 1);
			hLine.graphics.endFill();
			addChild(hLine);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function openLevel(level:Object):void {
			levelLabel.text = levelName = level.name;
			hero.x = level.hero.x;
			hero.y = level.hero.y;
			for (var i:int = 0; i < level.items.length; i++) {
				var item:Item = new Item(level.items[i].type);
				item.x = level.items[i].x;
				item.y = level.items[i].y;
				editorContainer.addChild(item);
				item.addEventListener(MouseEvent.MOUSE_DOWN, editorItemMouseDown);
			}
		}

		private function onSetCoordinatesNumber(e:MouseEvent):void {
			currentItem.x = itemPanel.getText().x;
			currentItem.y = itemPanel.getText().y;
			if (currentItem.x + currentItem.width > 800) currentItem.x = 800 - currentItem.width;
			if (currentItem.y + currentItem.height > 600) currentItem.y = 600 - currentItem.height;
		}
		
		private function onRemoveItem(e:MouseEvent):void {
			unselectItems();
			currentItem.addEventListener(MouseEvent.MOUSE_DOWN, editorItemMouseDown);
			editorContainer.removeChild(currentItem);
		}

		private function onListItemMouseDown(e:MouseEvent):void {
			var tempListItem:Item = e.currentTarget as Item;
			var point:Point = new Point(tempListItem.x, tempListItem.y);
			var globalPoint:Point = patternsContainer.localToGlobal(point);
			
			itemCandidate = new Item(tempListItem.type);
			itemCandidate.x = globalPoint.x;
			itemCandidate.y = globalPoint.y;
			addChild(itemCandidate);
			itemCandidate.startDrag();
			itemCandidate.filters = [new DropShadowFilter(0,0,0,1,8,8,1)];
			stage.addEventListener(MouseEvent.MOUSE_UP, onListItemMouseUp);
		}
		
		private function onListItemMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onListItemMouseUp);
			stopDrag();
			if (stage.mouseX <= 800 && stage.mouseY <= 600) {
				if (itemCandidate.x + itemCandidate.width > 800) itemCandidate.x = 800 - itemCandidate.width;
				if (itemCandidate.y + itemCandidate.height > 600) itemCandidate.y = 600 - itemCandidate.height;
				if (itemCandidate.x < 0) itemCandidate.x = 0;
				if (itemCandidate.y < 0) itemCandidate.y = 0;
				itemCandidate.filters = null;
				editorContainer.addChild(itemCandidate);
			    itemCandidate.addEventListener(MouseEvent.MOUSE_DOWN, editorItemMouseDown);
			} else {
				removeChild(itemCandidate);
				itemCandidate = null;
			}
		}
		
		private function editorItemMouseDown(e:MouseEvent):void {
			unselectItems();
			currentItem = e.currentTarget as Item;
			
			if (!currentItem.selected) currentItem.select();
			
			var bounds:Rectangle = new Rectangle(0, 0, 800 - e.currentTarget.width, 600 - e.currentTarget.height);
			currentItem.startDrag(false, bounds);
			
			itemSelected = true;
			
			addChild(itemPanel);
			itemPanel.setText(Math.round(currentItem.x), Math.round(currentItem.y));
			if (currentItem != hero) {
				itemPanel.removeButton.visible = true;
			} else {
				itemPanel.removeButton.visible = false;
			}
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(Event.ENTER_FRAME, coordinatesTextUpdate);
		}
		
		private function coordinatesTextUpdate(e:Event):void {
			itemPanel.setText(Math.round(currentItem.x), Math.round(currentItem.y));
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(Event.ENTER_FRAME, coordinatesTextUpdate);
			stopDrag();
			currentItem.x = Math.round(currentItem.x);
			currentItem.y = Math.round(currentItem.y);
			itemPanel.setText(Math.round(currentItem.x), Math.round(currentItem.y));
		}
		
		private function onMouseClick(e:MouseEvent):void {
			if (stage.mouseX < 800 && mouseY < 600 && itemSelected && e.target == stage) {
				unselectItems();
			}
		}
		
		private function unselectItems():void {
			if (editorContainer.numChildren > 0) {
				for (var i:int = 0; i < editorContainer.numChildren; i++) {
					var tempItem:Item = editorContainer.getChildAt(i) as Item;
					if (tempItem.selected) tempItem.unselect();
				}
			}
			if (hero.selected) hero.unselect();
			if (this.contains(itemPanel)) removeChild(itemPanel);
			itemSelected = false;
		}
		
		private function collectLevelData():Object {
			var data:Object 
			data = { num:0, name:levelName, hero: { x:hero.x, y:hero.y }};
			var itemsArray:Array = [];
			for (var i:int = 0; i < editorContainer.numChildren; i++) {
				var tempItem:Item = editorContainer.getChildAt(i) as Item;
				itemsArray.push( { type:tempItem.type, x:tempItem.x, y:tempItem.y, width:tempItem.width, height:tempItem.height } );
			}
			data.items = itemsArray;
			return data;
		}
		
		public function get levelData():Object {
			return _levelData;
		}
		
		private function saveLevel(e:MouseEvent = null):void {
			if (editorContainer.numChildren > 0) StorageManager.writeLevel(collectLevelData());
		}
		
		private function playLevel(e:MouseEvent):void {
			if (editorContainer.numChildren > 0) {
				_levelData = collectLevelData();
				dispatchEvent(new EditorEvent(EditorEvent.PLAY_LEVEL));
			}
		}
		
		private function gotoMainMenu(e:MouseEvent):void {
			if (editorContainer.numChildren > 0) {
				var buttons:Vector.<Object> = new <Object>[{label:"YES", func:exitWithSave}, {label:"NO", func:exitWithoutSave}];
				var ask:AskWindow = new AskWindow("SAVE CURRENT LEVEL?", buttons);
				addChild(ask);
			} else {
				dispatchEvent(new EditorEvent(EditorEvent.MAIN_MENU));
			}
		}
		
		private function exitWithSave(e:MouseEvent):void {
			saveLevel();
			dispatchEvent(new EditorEvent(EditorEvent.MAIN_MENU));
		}
		
		private function exitWithoutSave(e:MouseEvent):void {
			dispatchEvent(new EditorEvent(EditorEvent.MAIN_MENU));
		}

		private function onRemovedFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			stage.removeEventListener(MouseEvent.CLICK, onMouseClick);
			playLevelButton.removeEventListener(MouseEvent.CLICK, playLevel);
			saveCurrentLevel.removeEventListener(MouseEvent.CLICK, saveLevel);
			backToMainMenu.removeEventListener(MouseEvent.CLICK, gotoMainMenu);
			hero.removeEventListener(MouseEvent.MOUSE_DOWN, editorItemMouseDown);
			for (var i:int = 0; i < patternsContainer.numChildren; i++) {
				(patternsContainer.getChildAt(i) as Item).removeEventListener(MouseEvent.MOUSE_DOWN, onListItemMouseDown);
			}
			
			for (var j:int = 0; j < editorContainer.numChildren; j++) {
				(editorContainer.getChildAt(j) as Item).removeEventListener(MouseEvent.MOUSE_DOWN, onListItemMouseDown);
			}
		}
		
	}
}