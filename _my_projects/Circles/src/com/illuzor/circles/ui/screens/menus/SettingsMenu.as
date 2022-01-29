package com.illuzor.circles.ui.screens.menus {
	
	import com.illuzor.circles.tools.Assets;
	import com.illuzor.circles.tools.StorageManager;
	import com.illuzor.circles.tools.VibroManager;
	import com.illuzor.circles.ui.Checkbox;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class SettingsMenu extends MenuBase {
		
		private var soundCheck:Checkbox;
		private var vibroCheck:Checkbox;
		
		public function SettingsMenu(text:String = "") {
			super(text);
		}
		
		override protected function start():void {
			var checkboxesContainer:Sprite = new Sprite();
			addChild(checkboxesContainer);
			
			soundCheck = new Checkbox(Assets.lang.texsts.sounds, backButtonHeight, StorageManager.getBool("sound"));
			checkboxesContainer.addChild(soundCheck);
			soundCheck.addEventListener(Event.CHANGE, onChangeSettings);
			
			if(VibroManager.isSupported){
				vibroCheck = new Checkbox(Assets.lang.texsts.vibration, backButtonHeight, StorageManager.getBool("vibro"));
				checkboxesContainer.addChild(vibroCheck);
				vibroCheck.y = soundCheck.height * 1.7;
				vibroCheck.addEventListener(Event.CHANGE, onChangeSettings);
			} else {
				StorageManager.setBool("vibro", false);
			}
			
			checkboxesContainer.x = (stage.stageWidth - checkboxesContainer.width) >> 1;
			checkboxesContainer.y = (stage.stageHeight - checkboxesContainer.height) >> 1;
		}
		
		private function onChangeSettings(e:Event):void {
			switch (e.target) {
				case soundCheck:
					StorageManager.setBool("sound", soundCheck.activated);
				break;
				case vibroCheck:
					StorageManager.setBool("vibro", vibroCheck.activated);
				break;
			}
		}
		
	}
}