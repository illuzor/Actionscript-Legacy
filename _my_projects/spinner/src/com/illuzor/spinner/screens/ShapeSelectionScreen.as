package com.illuzor.spinner.screens {
	
	import com.illuzor.spinner.constants.Difficulty;
	import com.illuzor.spinner.constants.ScreenType;
	import com.illuzor.spinner.controllers.AppController;
	import com.illuzor.spinner.events.ScreenEvent;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ShapeSelectionScreen extends ScreenBase {
		
		private var buttonsNames:Vector.<String> = new <String>["btn_circle", "btn_triangle", "btn_square", "btn_pentagon", "btn_hexagon"];
		
		override protected function start():void {
			var atlas:TextureAtlas = AppController.assetManager.getTextureAtlas("atlas1");
			
			var buttonsContainer:Sprite = new Sprite();
			addChild(buttonsContainer);
			
			var counter:uint = 2;
			
			for (var i:int = 0; i < buttonsNames.length; i++) {
				var button:Button = new Button(atlas.getTexture(buttonsNames[i]));
				buttonsContainer.addChild(button);
				button.x = 280 * i;
				button.name = String(counter);
				button.addEventListener(Event.TRIGGERED, onButtonClick);
				counter++;
			}
			
			buttonsContainer.width = stageWidth * .7;
			buttonsContainer.scaleY = buttonsContainer.scaleX;
			
			buttonsContainer.x = (stageWidth - buttonsContainer.width) >> 1;
			buttonsContainer.y = (stageHeight - buttonsContainer.height) >> 1;
		}
		
		private function onButtonClick(e:Event):void {
			var screenType:uint = uint((e.target as Button).name);
			dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, ScreenType.GAME_SCREEN, { shape:screenType, diff:Difficulty.EASY } ));
		}
		
		override public function hide():void {
			super.hide();
			
		}
		
		override public function dispose():void {
			
			super.dispose();
		}
		
	}
}