package com.illuzor.circles.ui.screens.menus {
	
	import com.illuzor.circles.constants.GameType;
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
	
	public class GameModesMenu extends MenuBase {
		
		private var timeChallangeButton:TextButton;
		private var sizeChallangeButton:TextButton;
		private var completeChallangeButton:TextButton;
		
		public function GameModesMenu() {
			super("");
		}
		
		override protected function start():void {
			var buttonsContainer:Sprite = new Sprite();
			addChild(buttonsContainer);
			
			timeChallangeButton = new TextButton(Assets.lang.texsts["timeChallange"]);
			buttonsContainer.addChild(timeChallangeButton);
			
			sizeChallangeButton = new TextButton(Assets.lang.texsts["sizeChallange"]);
			sizeChallangeButton.y = buttonsContainer.height+timeChallangeButton.height * .8;
			buttonsContainer.addChild(sizeChallangeButton);
			
			completeChallangeButton = new TextButton(Assets.lang.texsts["completeChallange"]);
			completeChallangeButton.y = buttonsContainer.height+timeChallangeButton.height * .8;
			buttonsContainer.addChild(completeChallangeButton);
			
			for (var i:int = 0; i < buttonsContainer.numChildren; i++) {
				var button:TextButton = buttonsContainer.getChildAt(i) as TextButton;
				button.x = (buttonsContainer.width - button.width) >> 1;
			}
			
			if (buttonsContainer.width > stage.stageWidth * .7) {
				buttonsContainer.width = (stage.stageWidth * .7);
				buttonsContainer.scaleY = buttonsContainer.scaleX;
			}
			
			buttonsContainer.x = (stage.stageWidth - buttonsContainer.width) >> 1;
			buttonsContainer.y = (stage.stageHeight - buttonsContainer.height) >> 1;
			
			timeChallangeButton.addEventListener(TextButtonEvent.TRIGGERED, onButtonTrigered);
			sizeChallangeButton.addEventListener(TextButtonEvent.TRIGGERED, onButtonTrigered);
			completeChallangeButton.addEventListener(TextButtonEvent.TRIGGERED, onButtonTrigered);
		}
		
		private function onButtonTrigered(e:Event):void {
			clear();
			extraClear();
			switch ((e.target as TextButton).text) {
				case Assets.lang.texsts["timeChallange"]:
					dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, ScreenType.GAME_SCREEN, GameType.TIME));
				break;
				
				case Assets.lang.texsts["sizeChallange"]:
					dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, ScreenType.GAME_SCREEN, GameType.SIZE));
				break;
				
				case Assets.lang.texsts["completeChallange"]:
					dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, ScreenType.GAME_SCREEN, GameType.COMPLETE));
				break;
			}
		}
		
		override protected function extraClear():void {
			timeChallangeButton.removeEventListener(TextButtonEvent.TRIGGERED, onButtonTrigered);
			sizeChallangeButton.removeEventListener(TextButtonEvent.TRIGGERED, onButtonTrigered);
			completeChallangeButton.removeEventListener(TextButtonEvent.TRIGGERED, onButtonTrigered);
		}
		
	}
}