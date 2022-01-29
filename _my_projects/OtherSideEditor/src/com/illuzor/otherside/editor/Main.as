package com.illuzor.otherside.editor {
	
	import com.illuzor.otherside.editor.screen.MainMenu;
	import com.illuzor.otherside.editor.screen.ScreenManager;
	import com.illuzor.otherside.editor.tools.GlobalResizer;
	import com.illuzor.otherside.editor.tools.StorageManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	import RondaFont;
	
	RondaFont;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		public function Main():void {
			Font.registerFont(RondaFont);
			StorageManager.init();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			GlobalResizer.init(stage);
			addChild(new ScreenManager());
		}
		
	}
	
}