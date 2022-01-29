package com.illuzor.circles.ui.screens.menus {
	
	import com.illuzor.circles.constants.ScreenType;
	import com.illuzor.circles.events.ScreenEvent;
	import com.illuzor.circles.events.TextButtonEvent;
	import com.illuzor.circles.tools.Assets;
	import com.illuzor.circles.ui.TextButton;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MenuBase extends Sprite {
		
		private var backButton:TextButton;
		protected var backButtonHeight:uint;
		
		public function MenuBase(text:String = "") {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
			backButton = new TextButton(Assets.lang.texsts.back);
			addChild(backButton);
			
			var backButtonWidth:uint = stage.stageWidth >> 2;
			
			if (backButton.width >  backButtonWidth) {
				backButton.width = backButtonWidth;
				backButton.scaleY = backButton.scaleX;
			}
			
			backButtonHeight = backButton.height;
			
			
			backButton.x = (stage.stageWidth - backButton.width) >> 1;
			backButton.y = stage.stageHeight - (backButton.height << 1);
			backButton.addEventListener(TextButtonEvent.TRIGGERED, onBack);
			start();
		}
		
		protected function start():void {
			throw new Error("MenuBase.start() must be overrided");
		}
		
		private function onBack(e:TextButtonEvent):void {
			clear();
			extraClear();
			dispatchEvent(new ScreenEvent(ScreenEvent.GOTO_MAIN, ScreenType.MAIN_MENU));
		}
		
		protected function clear():void {
			backButton.removeEventListener(TextButtonEvent.TRIGGERED, onBack);
		}
		
		protected function extraClear():void {
			// may be overrided
		}
		
	}
}