package com.illuzor.otherside.editor.screen {
	
	import adobe.utils.CustomActions;
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import com.illuzor.framework.display.FastRect;
	import com.illuzor.otherside.constants.AsteroidType;
	import com.illuzor.otherside.constants.Colors;
	import com.illuzor.otherside.constants.EnemyType;
	import com.illuzor.otherside.constants.WaveType;
	import com.illuzor.otherside.editor.constants.ComponentEventType;
	import com.illuzor.otherside.editor.constants.ScreenType;
	import com.illuzor.otherside.editor.events.ComponentEvent;
	import com.illuzor.otherside.editor.events.EnemyEvent;
	import com.illuzor.otherside.editor.events.ScreenEvent;
	import com.illuzor.otherside.editor.events.WaveItemEvent;
	import com.illuzor.otherside.editor.screen.components.CheckText;
	import com.illuzor.otherside.editor.screen.components.ComponentBase;
	import com.illuzor.otherside.editor.screen.components.ImageChooser;
	import com.illuzor.otherside.editor.screen.components.MultipleChoise;
	import com.illuzor.otherside.editor.screen.components.TextWithCombo;
	import com.illuzor.otherside.editor.screen.components.TextWithSlider;
	import com.illuzor.otherside.editor.screen.elements.Dialog;
	import com.illuzor.otherside.editor.screen.elements.WaveItem;
	import com.illuzor.otherside.editor.screen.gameElements.Enemy;
	import com.illuzor.otherside.editor.tools.Assets;
	import com.illuzor.otherside.editor.tools.LevelsStorage;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class EditorScreen extends ScreenBase {
		
		private var levelConfig:Object;
		private var wavesList:Vector.<WaveItem> = new Vector.<WaveItem>();
		private var enemiesList:Vector.<Enemy> = new Vector.<Enemy>();
		private var zone:uint;
		private var level:uint;
		private var idCounter:uint;
		private var addWaveDialog:Dialog;
		private var exitDialog:Dialog;
		private var parseErrorDialog:Dialog;
		private var deleteItemDialog:Dialog;
		private var nothingToSaveDialog:Dialog;
		private var addWaveButton:PushButton;
		private var saveButton:PushButton;
		private var backButton:PushButton;
		private var gameContainer:Sprite;
		private var wavesContainer:Sprite;
		private var waveConfButtonsContainer:Sprite;
		private var currentSelectedItem:WaveItem;
		private var selectedWave:WaveItem;
		private var currentWaveType:String = "";
		private var gameArea:Sprite;
		private var selectedEnemy:Enemy;
		private var extraSettingsContainer:Sprite;
		private var grid:Shape;
		private var gridSize:uint;
		private var attachToGrid:Boolean;
		private var attachToGridToCenter;
		
		public function EditorScreen(zone:uint, level:uint) {
			this.level = level;
			this.zone = zone;
			var levelString:String = LevelsStorage.getLevel(zone, level);
			try {
				levelConfig = JSON.parse(levelString);
				makeUI();
				makeCommonSettings();
				parseConfig();
			} catch (e:Error) {
				var editButton:PushButton = new PushButton(null, 0, 0, "EDIT");
				var newButton:PushButton = new PushButton(null, 0, 0, "CREATE CONFIG");
				parseErrorDialog = new Dialog("UNABLE TO PARSE CONFIG." , new <Object> [
					{ button:editButton, func:onErrorClick },
					{ button:newButton, func:onErrorClick } ]);
				addChild(parseErrorDialog);
			}
		}
		
		private function parseConfig():void {
			for (var i:int = 0; i < levelConfig.waves.length; i++) {
				addWave(levelConfig.waves[i].type, stageWidth - gameContainer.width - 2, levelConfig.waves[i]);
			}
		}
		
		private function onErrorClick(e:MouseEvent):void {
			parseErrorDialog.dispose();
			removeChild(parseErrorDialog);
			if (e.currentTarget.label == "EDIT") {
				LevelsStorage.openLevelsFolder();
				dispatchEvent(new ScreenEvent(ScreenEvent.SCHANGE_SCREEN, ScreenType.LEVEL_SELECTION_SCREEN));
			} else {
				levelConfig = { waves:[] };
				makeUI();
				makeCommonSettings();
			}
		}
		
		[Inline]
		private final function makeUI():void {
			gameContainer = new Sprite();
			gameContainer.graphics.beginFill(0x272727);
			gameContainer.graphics.drawRect(0, 0, 960 + 200, 640 + 200);
			gameContainer.graphics.endFill();
			addChild(gameContainer);
			
			gameArea = new Sprite();
			gameArea.x = gameArea.y = 100;
			gameArea.graphics.lineStyle(1, 0x000000, .65);
			gameArea.graphics.beginFill(0x0, 1);
			gameArea.graphics.drawRect(0, 0, 960, 640);
			gameArea.graphics.endFill();
			gameContainer.addChild(gameArea);
			
			var rightGapWidth:uint = stageWidth - gameContainer.width;
			
			var wavesLabel:Label = new Label(this, 0, 0, "WAVES");
			wavesLabel.textField.textColor = 0x0;
			wavesLabel.x = ((rightGapWidth-wavesLabel.width) >> 1) + gameContainer.width;
			wavesLabel.y = 5;
			
			addWaveButton = new PushButton(this, 0, 0, "ADD WAVE");
			addWaveButton.width = rightGapWidth - 4;
			addWaveButton.x = gameContainer.width + 2;
			addWaveButton.y = gameContainer.height - addWaveButton.height;
			
			wavesContainer = new Sprite();
			wavesContainer.x = gameContainer.width + 2;
			wavesContainer.y = wavesLabel.y + wavesLabel.height + 5;
			addChild(wavesContainer);
			wavesContainer.graphics.beginFill(0xE9E9E9, .5);
			wavesContainer.graphics.drawRect(0, 0, rightGapWidth-4, gameContainer.height - (wavesLabel.y + wavesLabel.height + 6 + addWaveButton.height) );
			wavesContainer.graphics.endFill();
			
			var rightSeparator:FastRect = new FastRect(1, rightGapWidth - 2, 0xFFFFFF, .2);
			rightSeparator.x = gameContainer.width;
			rightSeparator.y = gameContainer.height + 1;
			addChild(rightSeparator);
			
			saveButton = new PushButton(this, gameContainer.width + 2, gameContainer.height + 4, "SAVE");
			saveButton.width = (rightGapWidth >> 1) - 4;
			
			backButton = new PushButton(this, saveButton.x+saveButton.width + 2, gameContainer.height + 4, "BACK");
			backButton.width = (rightGapWidth >> 1) - 4;
			
			waveConfButtonsContainer = new Sprite();
			addChild(waveConfButtonsContainer);
			waveConfButtonsContainer.x = 10;
			waveConfButtonsContainer.y = gameContainer.height + 10;
			
			extraSettingsContainer = new Sprite()
			
			addWaveButton.addEventListener(MouseEvent.CLICK, onMainButtonClick);
			saveButton.addEventListener(MouseEvent.CLICK, onMainButtonClick);
			backButton.addEventListener(MouseEvent.CLICK, onMainButtonClick);
			addEventListener(ComponentEvent.CHANGE_VALUE, onValueChange);
			gameArea.addEventListener(EnemyEvent.SELECTED, onEnemySelected);
		}
		
		[Inline]
		private final function makeCommonSettings():void {
			
			grid = new Shape();
			grid.visible = false;
			gameArea.addChild(grid);
			
			var commonSettingsContainer:Sprite = new Sprite();
			addChild(commonSettingsContainer);
			
			var gridVisible:CheckText = new CheckText(ComponentEventType.GRID_VISIBLE, 200, "GRID VISIBLE");
			commonSettingsContainer.addChild(gridVisible);
			
			var gridSize:TextWithSlider = new TextWithSlider("GRID SIZE", 2, 100, ComponentEventType.GRID_SIZE);
			gridSize.y = 22;
			commonSettingsContainer.addChild(gridSize);
			
			var attachToGrid:CheckText = new CheckText(ComponentEventType.GRID_ATTACH, 200, "ATTACH TO GRID");
			attachToGrid.y = 44;
			commonSettingsContainer.addChild(attachToGrid);
			
			var attachToCenter:CheckText = new CheckText(ComponentEventType.GRID_ATTACH_TO_CENTER, 200, "ATTACH TO CENTER");
			attachToCenter.y = 66;
			commonSettingsContainer.addChild(attachToCenter);
			
			commonSettingsContainer.x = gameContainer.width - commonSettingsContainer.width - 20;
			commonSettingsContainer.y = gameContainer.height + 20;
			
			drawGrid(20);
		}
		
		private function drawGrid(size:uint):void { // TODO сделать точку отсчёта от центра
			var totalW:uint = Math.floor(960 / size) + 1;
			var totalH:uint = Math.floor(640 / size) + 1;
			
			grid.graphics.clear();
			grid.graphics.lineStyle(1, 0xFFFFFF, .3);
			
			for (var i:int = 0; i < totalH; i++) {
				grid.graphics.moveTo(0, i * size);
				grid.graphics.lineTo(960, i * size);
			}
			
			for (var j:int = 0; j < totalW; j++) {
				grid.graphics.moveTo(j * size, 0);
				grid.graphics.lineTo(j * size, 640);
			}
		}
		
		private function onEnemySelected(e:EnemyEvent):void {
			selectedEnemy = e.enemy;
			for (var i:int = 0; i < enemiesList.length; i++) {
				if (enemiesList[i] != selectedEnemy) enemiesList[i].deselect();
			}
			
			addChild(extraSettingsContainer);
			extraSettingsContainer.x = waveConfButtonsContainer.width + 20;
			extraSettingsContainer.y = waveConfButtonsContainer.y;
			
			var enemyColor:TextWithCombo = new TextWithCombo(ComponentEventType.ASTEROID_COLOR, 240, "Color", ["RED", "GREEN", "BLUE", "YELLOW", "ORANGE"]);
			extraSettingsContainer.addChild(enemyColor);
		}
		
		private function onValueChange(e:ComponentEvent):void {
			//trace(e.eventData.type, e.eventData.value)
			e.stopImmediatePropagation();
			switch (int(e.eventData.type)) {
				case ComponentEventType.ASTEROID_DELAY:
				case ComponentEventType.WAVE_FLASH_DELAY:
					currentSelectedItem.data.time = e.eventData.value;
				break;
				
				case ComponentEventType.ASTEROID_AMOUTN:
					currentSelectedItem.data.asteroidAmount = e.eventData.value; 
				break;
				
				case ComponentEventType.ASTEROID_COLOR:
					currentSelectedItem.data.color = Colors[String(e.eventData.value)];
				break;
				
				case ComponentEventType.ASTEROID_TYPES:
					var typesVector:Vector.<Boolean> = e.eventData.value;
					var typesArray:Array = [];
					if (typesVector[0]) typesArray.push(AsteroidType.ASTEROIDS_SMALL);
					if (typesVector[1]) typesArray.push(AsteroidType.ASTEROIDS_MEDIUM1);
					if (typesVector[2]) typesArray.push(AsteroidType.ASTEROIDS_MEDIUM2);
					if (typesVector[3]) typesArray.push(AsteroidType.ASTEROIDS_BIG);
					currentSelectedItem.data.types = typesArray;
				break;
				
				case ComponentEventType.WAVE_FLASH_TYPE:
					currentSelectedItem.data.waweType = e.eventData.value;
				break;
				
				case ComponentEventType.WAVE_FLASH_ENEMY:
					makeEnemy(EnemyType["ENEMY" + String(e.eventData.value)]);
				break;
				
				case ComponentEventType.GRID_VISIBLE:
					grid.visible = e.eventData.value;
				break;
				
				case ComponentEventType.GRID_SIZE:
					gridSize = e.eventData.value
					drawGrid(gridSize);
				break;
				
				case ComponentEventType.GRID_ATTACH:
					attachToGrid = e.eventData.value;
				break;
				
				case ComponentEventType.GRID_ATTACH_TO_CENTER:
					attachToGridToCenter = e.eventData.value;
				break;
			}
		}
		
		private function makeEnemy(enemyType:String):void {
			var enemy:Enemy = new Enemy(Assets.gamenAtlas.getBitmap(enemyType), enemyType);
			enemiesList.push(enemy);
			gameArea.addChild(enemy);
			enemy.addEventListener(MouseEvent.MOUSE_DOWN, onEnemyMouse);
			enemy.addEventListener(MouseEvent.MOUSE_UP, onEnemyMouse);
		}
		
		private function onEnemyMouse(e:MouseEvent):void {
			if ((e.currentTarget as Enemy).selected) {
				switch (e.type) {
					case MouseEvent.MOUSE_DOWN:
						selectedEnemy.startDrag(false, new Rectangle( -100, -100, gameArea.width - selectedEnemy.width + 200, gameArea.height - selectedEnemy.height + 200));
					break;
					case MouseEvent.MOUSE_UP:
						stopDrag();
						if (attachToGrid) {
							/*if (attachToGridToCenter) {
								selectedEnemy.x -= selectedEnemy.width / 2;
								selectedEnemy.y -= selectedEnemy.height / 2;
							} else {*/
								selectedEnemy.x = Math.round(selectedEnemy.x / gridSize) * gridSize;
								selectedEnemy.y = Math.round(selectedEnemy.y / gridSize) * gridSize;
							//}
						}
					break;
				}
			}
		}
		
		private function onMainButtonClick(e:MouseEvent):void {
			switch (e.currentTarget) {
				case addWaveButton:
					const buttonsNames:Vector.<String> = new <String> ["ASTEROIDS", "FLASH", "LINEAR MOVE", "BEZIER MOVE", "MINER", "BOSS"];
					const buttonTypes:Vector.<String> = new <String>[WaveType.ASTEROIDS, WaveType.FLASH, WaveType.LINEAR_MOVE, WaveType.BEZIER_MOVE, WaveType.MINER, WaveType.BOSS];
					var buttons:Vector.<Object> = new Vector.<Object>();
					for (var i:int = 0; i < buttonsNames.length; i++) {
						var button:PushButton = new PushButton();
						button.label = buttonsNames[i];
						button.data = { type:buttonTypes[i] };
						buttons.push( { button:button, func:addWaveDialogButtonClick } );
					}
					addWaveDialog = new Dialog("SELECT WAVE TYPE", buttons, 3);
					addChild(addWaveDialog);
				break;
				case saveButton:
					saveLevelConfig();
				break;
				case backButton:
					var noButton:PushButton = new PushButton(null, 0, 0, "NO");
					var yesButton:PushButton = new PushButton(null, 0, 0, "YES");
					exitDialog = new Dialog("SAVE BEFORE EXIT?." , new <Object> [ { button:noButton, func:saveBeforeExitClick },
						{ button:yesButton, func:saveBeforeExitClick } ]);
					addChild(exitDialog);
				break;
			}
		}
		
		private function saveBeforeExitClick(e:MouseEvent):void {
			exitDialog.dispose();
			removeChild(exitDialog);
			if (e.currentTarget.label == "YES")
				saveLevelConfig();
				
			dispatchEvent(new ScreenEvent(ScreenEvent.SCHANGE_SCREEN, ScreenType.LEVEL_SELECTION_SCREEN));
		}
		
		private function saveLevelConfig():void {
			if (wavesList.length == 0) {
				nothingToSaveDialog = new Dialog("NOTHING TO SAVE", new < Object > [ { button:new PushButton(null, 0, 0, "OK"), func:removeNothingDialog } ] );
				addChild(nothingToSaveDialog);
			} else {
				for (var i:int = 0; i < wavesList.length; i++) {
					if (wavesList[i].type == WaveType.ASTEROIDS) {
						levelConfig.waves.push(wavesList[i].data);
					}
				}
				LevelsStorage.writeLevel(zone, level, levelConfig);
			}
		}
		
		private function removeNothingDialog(e:MouseEvent):void {
			nothingToSaveDialog.dispose();
			removeChild(nothingToSaveDialog);
		}
		
		private function addWaveDialogButtonClick(e:MouseEvent):void {
			addWaveDialog.dispose();
			removeChild(addWaveDialog);
			
			addWave(e.currentTarget.data.type, stageWidth - gameContainer.width - 2);
			idCounter++;
		}
		
		private function addWave(type:String, w:uint, data:Object = null):void {
			var wave:WaveItem = new WaveItem(type, w, idCounter);
			if (data) wave.data = data;
			wave.y = 28 * wavesContainer.numChildren;
			wavesContainer.addChild(wave);
			wavesList.push(wave);
			wave.addEventListener(WaveItemEvent.UP, onWaveButtonClick);
			wave.addEventListener(WaveItemEvent.DOWN, onWaveButtonClick);
			wave.addEventListener(WaveItemEvent.DELETE, onWaveButtonClick);
			wave.addEventListener(WaveItemEvent.SELECT, onWaveButtonClick);
		}
		
		private function onWaveButtonClick(e:WaveItemEvent):void {
			selectedWave = e.target as WaveItem;
			var waveIndex:uint = wavesList.indexOf(selectedWave)
			switch (e.type) {
				case WaveItemEvent.UP:
					if (waveIndex > 0) {
						swapItems(waveIndex - 1, waveIndex);
					}
				break;
				case WaveItemEvent.DOWN:
					if (waveIndex < wavesList.length - 1) {
						swapItems(waveIndex, waveIndex + 1);
					}
				break;
				case WaveItemEvent.DELETE:
					var noButton:PushButton = new PushButton(null, 0, 0, "NO");
					var yesButton:PushButton = new PushButton(null, 0, 0, "YES");
					deleteItemDialog = new Dialog("Sure? It will be undone." , new <Object> [
						{ button:noButton, func:deleteItemtDialogClick },
						{ button:yesButton, func:deleteItemtDialogClick } ]);
					addChild(deleteItemDialog);
				break;
				case WaveItemEvent.SELECT:
					if (currentSelectedItem && currentSelectedItem != selectedWave) {
						currentSelectedItem.deselect();
					}
					currentSelectedItem = selectedWave;
					makeWaveUI(currentSelectedItem.type);
				break;
			}
		}
		
		private function deleteItemtDialogClick(e:MouseEvent):void {
			deleteItemDialog.dispose();
			removeChild(deleteItemDialog);
			if (e.currentTarget.label == "YES") {
				selectedWave.removeEventListener(WaveItemEvent.UP, onWaveButtonClick);
				selectedWave.removeEventListener(WaveItemEvent.DOWN, onWaveButtonClick);
				selectedWave.removeEventListener(WaveItemEvent.DELETE, onWaveButtonClick);
				selectedWave.removeEventListener(WaveItemEvent.SELECT, onWaveButtonClick);
				wavesContainer.removeChild(selectedWave);
				wavesList.splice(wavesList.indexOf(selectedWave), 1);
				correctItemsPositions();
			}	
		}
		
		private function swapItems(first:uint, second:uint):void {
			wavesContainer.swapChildrenAt(first, second);
			wavesList = new Vector.<WaveItem>();
			for (var i:int = 0; i < wavesContainer.numChildren; i++) {
				wavesList.push(wavesContainer.getChildAt(i) as WaveItem);
			}
			correctItemsPositions();
		}
		
		[Inline]
		private final function correctItemsPositions():void {
			for (var i:int = 0; i < wavesList.length; i++) {
				wavesList[i].y = 28 * i;
			}
		}

		private function makeWaveUI(waveType:String):void {
			clear();
			switch (waveType) {
				case WaveType.ASTEROIDS:

					var colors:TextWithCombo = new TextWithCombo(ComponentEventType.ASTEROID_COLOR, 240, "Color", ["RED", "GREEN", "BLUE", "YELLOW", "ORANGE"]);
					waveConfButtonsContainer.addChild(colors);
					if (currentSelectedItem.data.hasOwnProperty("color")) colors.setValue(getColorNameByValue(currentSelectedItem.data.color));

					var types:MultipleChoise = new MultipleChoise("Types", new < String > ["Small", "Medium1", "Medium2", "Big"], ComponentEventType.ASTEROID_TYPES, 240);
					types.y = 22;
					waveConfButtonsContainer.addChild(types);
					
					if (currentSelectedItem.data.hasOwnProperty("types")) {
						var typesBools:Vector.<Boolean> = new Vector.<Boolean>();
						var typesArray:Array = currentSelectedItem.data.types;
						typesBools.push(isArrayContainsString(typesArray, AsteroidType.ASTEROIDS_SMALL));
						typesBools.push(isArrayContainsString(typesArray, AsteroidType.ASTEROIDS_MEDIUM1));
						typesBools.push(isArrayContainsString(typesArray, AsteroidType.ASTEROIDS_MEDIUM2));
						typesBools.push(isArrayContainsString(typesArray, AsteroidType.ASTEROIDS_BIG));
						types.setValue(typesBools);
					}
					
					var asteroidDelay:TextWithSlider = new TextWithSlider("Delay (sec.)", 0, 20, ComponentEventType.ASTEROID_DELAY, 0.01, 240);
					asteroidDelay.y = 44;
					waveConfButtonsContainer.addChild(asteroidDelay);
					if (currentSelectedItem.data.hasOwnProperty("time")) asteroidDelay.setValue(currentSelectedItem.data.time);
					
					var amount:TextWithSlider = new TextWithSlider("Amount", 5, 300, ComponentEventType.ASTEROID_AMOUTN, 1, 240);
					amount.y = 66;
					waveConfButtonsContainer.addChild(amount);
					if (currentSelectedItem.data.hasOwnProperty("asteroidAmount")) amount.setValue(currentSelectedItem.data.asteroidAmount);
					
					waveConfButtonsContainer.addChild(colors);
				break;
				case WaveType.FLASH:
					var enemyDelay:TextWithSlider = new TextWithSlider("Delay (sec.)", 0, 20, ComponentEventType.WAVE_FLASH_DELAY, 0.01, 240);
					waveConfButtonsContainer.addChild(enemyDelay);
					if (currentSelectedItem.data.hasOwnProperty("time")) enemyDelay.setValue(currentSelectedItem.data.time);
					
					var flashType:TextWithCombo = new TextWithCombo(ComponentEventType.WAVE_FLASH_TYPE, 240, "Flash Type", ["REGULAR", "RANDOM"]);
					flashType.y = 44;
					waveConfButtonsContainer.addChild(flashType);
					
					var enemiesImages:Vector.<Sprite> = new Vector.<Sprite>();
					for (var i:int = 0; i < 5; i++) {
						var img:Sprite = Assets.gamenAtlas.getSprite("enemy" + String(i + 1));
						img.buttonMode = true;
						img.name = String(i + 1);
						enemiesImages.push(img);
					}
					
					var enemyChoser:ImageChooser = new ImageChooser(ComponentEventType.WAVE_FLASH_ENEMY, 240, "ADD ENEMY", "ADD NEW", enemiesImages);
					enemyChoser.y = 22;
					waveConfButtonsContainer.addChild(enemyChoser);
					
				break;
				
				case WaveType.LINEAR_MOVE:
					
				break;
				
				case WaveType.BEZIER_MOVE:
					
				break;
				
				case WaveType.MINER:
					
				break;
				
				case WaveType.BOSS:
					
				break;
			}
			currentWaveType = waveType;
		}
		
		private function clear():void {
			for (var i:int = 0; i < waveConfButtonsContainer.numChildren; i++) {
				(waveConfButtonsContainer.getChildAt(i) as ComponentBase).dispose();
			}
			waveConfButtonsContainer.removeChildren();
			
			if (this.contains(extraSettingsContainer)) {
				for (var j:int = 0; j < extraSettingsContainer.numChildren; j++) {
					(extraSettingsContainer.getChildAt(j) as ComponentBase).dispose();
				}
				extraSettingsContainer.removeChildren();
				removeChild(extraSettingsContainer);
				gameArea.removeChildren();
			}
			//configButtons = null;
			/*switch (currentWaveType) {
				case WaveType.ASTEROIDS:
					
				break;
				case WaveType.BEZIER_MOVE:
					
				break;
				case WaveType.BOSS:
					
				break;
				case WaveType.FLASH:
					
				break;
				case WaveType.RANDOM_FLASH:
					
				break;
				case WaveType.LINEAR_MOVE:
					
				break;
			}*/
		}

		private function getColorNameByValue(color:uint):String {
			var value:String
			switch (color) {
				case 0xFF0000:
					value = "RED";
				break;
				case 0x00FF00:
					value = "GREEN";
				break;
				case 0x0000FF:
					value = "BLUE";
				break;
				case 0xFFFF00:
					value = "YELLOW";
				break;
				case 0xFF8000:
					value = "ORANGE";
				break;
			}
			return value;
		}

		private function isArrayContainsString(array:Array, string:String):Boolean {
			for (var i:int = 0; i < array.length; i++) {
				if (array[i] == string) {
					return true;
					break;
				}
			}
			return false;
		}
		
		override public function dispose():void {
			removeChildren();
			if (addWaveButton) {
				clear();
				addWaveButton.removeEventListener(MouseEvent.CLICK, onMainButtonClick);
				saveButton.removeEventListener(MouseEvent.CLICK, onMainButtonClick);
				backButton.removeEventListener(MouseEvent.CLICK, onMainButtonClick);
				waveConfButtonsContainer.removeEventListener(ComponentEvent.CHANGE_VALUE, onValueChange);
			}
		}
		
	}
}