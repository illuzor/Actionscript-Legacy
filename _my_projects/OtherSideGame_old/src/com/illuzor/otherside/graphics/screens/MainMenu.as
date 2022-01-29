package com.illuzor.otherside.graphics.screens {
	
	import com.illuzor.otherside.constants.ScreenType;
	import com.illuzor.otherside.events.ScreenEvent;
	import com.illuzor.otherside.tools.ResourceManager;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MainMenu extends ScreenBase {
		
		private var atlas:TextureAtlas;
		private var menuFont:BitmapFont;
		
		public function MainMenu(atlas:TextureAtlas) {
			this.atlas = atlas;
			menuFont = ResourceManager.font;
		}
		
		override protected function start():void {
			var buttonsContainer:Sprite = new Sprite();
			addChild(buttonsContainer);
			
			var playButton:Button = new Button(atlas.getTexture("button_play"));
			buttonsContainer.addChild(playButton);
			
			var settingsButton:Button = new Button(atlas.getTexture("button_settings"));
			settingsButton.y = playButton.height + 20;
			buttonsContainer.addChild(settingsButton);
			
			var aboutButton:Button = new Button(atlas.getTexture("button_about"));
			aboutButton.y = settingsButton.height +settingsButton.y + 20;
			buttonsContainer.addChild(aboutButton);
			
			buttonsContainer.x = (stageWidth - buttonsContainer.width) >> 1;
			buttonsContainer.y = (stageHeight - buttonsContainer.height) >> 1;
			
			playButton.addEventListener(TouchEvent.TOUCH, onPlayTouch);
		}
		
		private function onPlayTouch(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (touch.phase == TouchPhase.ENDED)
				dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, ScreenType.GAME_SCREEN, true));
		}
		
		override public function dispose():void {
			atlas.dispose();
			atlas = null;
			super.dispose();
		}
		
	}
}