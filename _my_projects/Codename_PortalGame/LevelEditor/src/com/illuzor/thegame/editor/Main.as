package com.illuzor.thegame.editor {
	
	import com.illuzor.thegame.editor.constants.ScreenType;
	import com.illuzor.thegame.editor.events.EditorEvent;
	import com.illuzor.thegame.editor.events.SelectLevelEvent;
	import com.illuzor.thegame.editor.events.TestLevelEvent;
	import com.illuzor.thegame.editor.notifications.AskWindow;
	import com.illuzor.thegame.editor.panels.EnterCodenamePanel;
	import com.illuzor.thegame.editor.panels.MainMenuPanel;
	import com.illuzor.thegame.editor.panels.SelectLevelPanel;
	import com.illuzor.thegame.editor.tools.LibLoader;
	import com.illuzor.thegame.editor.tools.StorageManager;
	import com.illuzor.thegame.events.LibEvent;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class Main extends Sprite {
		
		private var editor:Editor;
		private var game:GameView;
		private var menu:MainMenuPanel;
		private var enterNamePanel:EnterCodenamePanel;
		private var selectLevelPanel:SelectLevelPanel;
		private var currentScreen:String = ScreenType.MAIN_MENU;
		private var backupWarningDialog:AskWindow;
		
		public function Main():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			StorageManager.init();
			
			var loader:LibLoader = new LibLoader();
			loader.addEventListener(LibEvent.LIB_LOADED, start);
		}

		private function start(e:LibEvent):void {
			showMenu();
		}
		
		private function showMenu():void {
			if (!menu) {
				menu = new MainMenuPanel();
				menu.addEventListener(MouseEvent.CLICK, onMouseMenuClick);
			}
			
			addChild(menu);
			menu.x = (stage.stageWidth - menu.width) / 2;
			menu.y = (stage.stageHeight - menu.height) / 2;
			currentScreen = ScreenType.MAIN_MENU;
		}
		
		private function onMouseMenuClick(e:MouseEvent):void {
			switch(e.target) {
				case menu.newLevel:
					showEnterLevelName();
					currentScreen = ScreenType.ENTER_LEVEL_NAME;
					removeChild(menu);
					break;
					
				case menu.editLevel:
					showLevelSelect();
					currentScreen = ScreenType.SELECT_LEVEL;
					removeChild(menu);
					break;
				
				case menu.importConfig:
					//
					showBackupWarningDialog();
					break;
					
				case menu.exportConfig:
					StorageManager.exportConfig();
					break;
			}
			
		}
		
		private function showBackupWarningDialog():void {
			var buttons:Vector.<Object> = new < Object > [ { label:"CONTINUE", func:openFile }, { label:"CANCEL", func:cancelOpenFile } ];
			backupWarningDialog = new AskWindow("Recommended to make backup before import", buttons);
			addChild(backupWarningDialog)
		}
		
		private function openFile(e:MouseEvent):void {
			removeChild(backupWarningDialog);
			StorageManager.importConfig();
		}
		
		private function cancelOpenFile(e:MouseEvent):void {
			removeChild(backupWarningDialog);
		}
		
		private function showLevelSelect():void {
			selectLevelPanel = new SelectLevelPanel(StorageManager.getAllLevels());
			addChild(selectLevelPanel);
			selectLevelPanel.x = uint((stage.stageWidth - selectLevelPanel.width) / 2);
			selectLevelPanel.y = uint((stage.stageHeight - selectLevelPanel.height) / 2);
			selectLevelPanel.addEventListener(SelectLevelEvent.CANCEL, gotoMainMenu);
			selectLevelPanel.addEventListener(SelectLevelEvent.LEVEL_SELECTED, onExistingLevelSelected);
		}
		
		private function onExistingLevelSelected(e:SelectLevelEvent):void {
			clear();
			createNewLevel("");
			editor.openLevel(StorageManager.getCurrentLevel(selectLevelPanel.selectedLevel));
		}
		
		private function gotoMainMenu(e:Event):void {
			clear();
			showMenu();
		}
		
		private function showEnterLevelName():void {
			enterNamePanel = new EnterCodenamePanel();
			addChild(enterNamePanel);
			enterNamePanel.x = uint((stage.stageWidth - enterNamePanel.width) / 2);
			enterNamePanel.y = uint((stage.stageHeight - enterNamePanel.height) / 2);
			enterNamePanel.addEventListener(MouseEvent.CLICK, onEnterPanelClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onEnterName);
		}
		
		private function onEnterName(e:KeyboardEvent):void {
			if (e.keyCode == 13) {
				continueToEditor();
			}
		}
		
		private function onEnterPanelClick(e:MouseEvent):void {
			if (e.target == enterNamePanel.okButton) {
				continueToEditor();
			} else if (e.target == enterNamePanel.cancelButton) {
				clear()
				showMenu();
			}
		}
		
		private function continueToEditor():void {
			if (StorageManager.checkNameSimulation(enterNamePanel.enteredName) && enterNamePanel.enteredName.length > 0) {
					clear()
					createNewLevel(enterNamePanel.enteredName);
					currentScreen = ScreenType.EDITOR;
				} else {
					if (!StorageManager.checkNameSimulation(enterNamePanel.enteredName)) enterNamePanel.showError("THIS NAME ALREADY EXIST");
					if(enterNamePanel.enteredName.length <=0 ) enterNamePanel.showError("ZERO LENGTH NAME");
				}
		}
		
		private function createNewLevel(levelName:String):void {

			editor = new Editor(levelName);
			addChild(editor);
			currentScreen = ScreenType.EDITOR;

			editor.addEventListener(EditorEvent.PLAY_LEVEL, onPlayLevel);
			editor.addEventListener(EditorEvent.MAIN_MENU, gotoMainMenu);
		}
		
		private function onPlayLevel(e:EditorEvent):void {
			editor.visible = false;
			
			if(!game) game = new GameView();
			
			game.start(editor.levelData);
			addChild(game);
			game.addEventListener(TestLevelEvent.RETURN_TO_EDITOR, backToEditor);
		}
		
		private function backToEditor(e:TestLevelEvent):void {
			game.removeEventListener(TestLevelEvent.RETURN_TO_EDITOR, backToEditor);
			removeChild(game);
			game.stopp();
			editor.visible = true;
		}
		
		private function clear():void {
			trace(currentScreen)
			switch(currentScreen) {
				case ScreenType.MAIN_MENU:
				break;
				
				case ScreenType.ENTER_LEVEL_NAME:
					enterNamePanel.removeEventListener(MouseEvent.CLICK, onEnterPanelClick);
					removeChild(enterNamePanel);
				break;
				
				case ScreenType.EDITOR:
					editor.removeEventListener(EditorEvent.PLAY_LEVEL, onPlayLevel);
					editor.removeEventListener(EditorEvent.MAIN_MENU, gotoMainMenu);
					removeChild(editor);
				break;
				
				case ScreenType.TEST_LEVEL:
				break;
				
				case ScreenType.SELECT_LEVEL:
					selectLevelPanel.removeEventListener(SelectLevelEvent.CANCEL, gotoMainMenu);
					selectLevelPanel.removeEventListener(SelectLevelEvent.LEVEL_SELECTED, onExistingLevelSelected);
					removeChild(selectLevelPanel);
				break;
			}
		}
		
	}
}