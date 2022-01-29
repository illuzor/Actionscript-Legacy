package com.illuzor.bubbles.screens {
	
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import com.illuzor.bubbles.constants.ScreenType;
	import com.illuzor.bubbles.events.ScreenEvent;
	import com.illuzor.bubbles.graphics.TextButton;
	import com.illuzor.bubbles.tools.ResourceManager;
	import starling.display.Button;
	import starling.events.Event;
	
	/**
	 * Главное меню. Отображает кнопку "play";
	 */
	
	public class MainMenu extends ScreenBase {
		
		private var playButton:Button;
		
		override protected function start():void {
			playButton = new TextButton(ResourceManager.getAtlas().getTexture("button_background"), "PLAY");
			playButton.x = stageWidth >> 1;
			playButton.y = stageHeight >> 1;
			addChild(playButton);
			playButton.addEventListener(Event.TRIGGERED, onButtonClick);
			playButton.scaleX = playButton.scaleY = 0;
			TweenLite.to(playButton, .5, { scaleX:1, scaleY:1, ease:Back.easeOut, delay:.2 } );
		}
		
		private function onButtonClick(e:Event):void {
			playButton.removeEventListener(Event.TRIGGERED, onButtonClick);
			dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, ScreenType.GAME_SCREEN));
		}
		
	}
}