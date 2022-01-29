package com.illuzor.otherside.editor.screen {
	
	import com.bit101.components.PushButton;
	import com.illuzor.otherside.editor.constants.ScreenType;
	import com.illuzor.otherside.editor.events.ScreenEvent;
	import com.illuzor.otherside.editor.Settings;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class LevelSelectionScreen extends ScreenBase {
		
		private var buttonContainer:Sprite;
		private var backButton:PushButton;
		
		public function LevelSelectionScreen() {
			buttonContainer = new Sprite();
			addChild(buttonContainer);
			for (var i:int = 0; i < Settings.TOTAL_ZONES; i++) {
				for (var j:int = 0; j < Settings.TOTAL_LEVELS; j++) {
					var button:PushButton = new PushButton(buttonContainer, i * 130, j * 26, "Zone " + String(i + 1) + ", Level " + String(j + 1));
					button.data = { zone:i+1, level:j+1 };
					button.addEventListener(MouseEvent.CLICK, onButtonClick);
				}
			}
			buttonContainer.x = (stageWidth - buttonContainer.width) >> 1;
			buttonContainer.y = (stageHeight - buttonContainer.height) >> 1;
			
			backButton = new PushButton(this, 0, 0, "BACK");
			backButton.x = (stageWidth - backButton.width) >> 1;
			backButton.y = buttonContainer.y + buttonContainer.height + 28;
			backButton.addEventListener(MouseEvent.CLICK, onBackClick);
		}
		
		private function onBackClick(e:MouseEvent):void {
			dispatchEvent(new ScreenEvent(ScreenEvent.SCHANGE_SCREEN, ScreenType.MAIN_MENU_SCREEN));
		}
		
		private function onButtonClick(e:MouseEvent):void {
			dispatchEvent(new ScreenEvent(ScreenEvent.SCHANGE_SCREEN, ScreenType.EDITOR_SCREEN, e.currentTarget.data));
		}
		
		override public function dispose():void {
			backButton.removeEventListener(MouseEvent.CLICK, onBackClick);
			for (var i:int = 0; i < buttonContainer.numChildren; i++) {
				(buttonContainer.getChildAt(i) as PushButton).removeEventListener(MouseEvent.CLICK, onButtonClick);
			}
		}
		
	}
}