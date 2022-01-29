package com.illuzor.otherside.editor.screen {
	
	import com.bit101.components.PushButton;
	import com.illuzor.otherside.editor.constants.ScreenType;
	import com.illuzor.otherside.editor.events.ScreenEvent;
	import com.illuzor.otherside.editor.screen.elements.Dialog;
	import com.illuzor.otherside.editor.tools.GlobalResizer;
	import com.illuzor.otherside.editor.tools.LevelsStorage;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MainMenu extends ScreenBase {
		
		private var startButton:PushButton;
		private var editButton:PushButton;
		private var exportButton:PushButton;
		private var importButton:PushButton;
		private var importDialog:Dialog;
		
		public function MainMenu() {
			
			var buttonsContainer:Sprite = new Sprite();
			addChild(buttonsContainer);
			
			startButton = new PushButton(buttonsContainer, 0, 0, "Run editor");
			editButton = new PushButton(buttonsContainer, 0, buttonsContainer.height + 10, "Edit with Notepad");
			exportButton = new PushButton(buttonsContainer, 0, buttonsContainer.height + 10, "Export Config");
			importButton = new PushButton(buttonsContainer, 0, buttonsContainer.height + 10, "Import Config");
			
			buttonsContainer.x = (GlobalResizer.stageWidth - buttonsContainer.width) >> 1;
			buttonsContainer.y = (GlobalResizer.stageHeight - buttonsContainer.height) >> 1;
			
			startButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			editButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			exportButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			importButton.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		private function onButtonClick(e:MouseEvent):void {
			switch (e.target) {
				case startButton:
					dispatchEvent(new ScreenEvent(ScreenEvent.SCHANGE_SCREEN, ScreenType.LEVEL_SELECTION_SCREEN));
				break;
				case editButton:
					LevelsStorage.openLevelsFolder();
				break;
				case exportButton:
					LevelsStorage.exportSettings();
				break;
				case importButton:
					showImportDialog();
				break;
			}
		}
		
		[Inline]
		private final function showImportDialog():void {
			var noButton:PushButton = new PushButton(null, 0, 0, "CANCEL");
			var yesButton:PushButton = new PushButton(null, 0, 0, "YES");
			importDialog = new Dialog("OMG! Sure? Make backup before! Import?", new < Object > [ { button:noButton, func:importDialogClick },
				{ button:yesButton, func:importDialogClick } ]);
			addChild(importDialog);
		}
		
		private function importDialogClick(e:Event):void {
			importDialog.dispose();
			removeChild(importDialog);
			if (e.currentTarget.label == "YES")
				LevelsStorage.importSettings();
		}
		
		override public function dispose():void {
			removeChildren();
			startButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			editButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			exportButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
			importButton.removeEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
	}
}