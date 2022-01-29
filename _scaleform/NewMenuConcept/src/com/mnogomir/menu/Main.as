package com.mnogomir.menu {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	//import scaleform.gfx.Extensions;
	//import exte
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class Main extends Sprite {
		private var background:Bitmap;
		
		public function Main():void {
			//Extensions.enabled = true;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//background = Assets.getImage("Background");
			background = new Bitmap(new BackGround());
			background.smoothing = true;
			addChild(background);
			
			var menu:MenuMain = new MenuMain();
			addChild(menu);
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event = null):void {
			placeBackground(background);
		}
		
		private function placeBackground(scaledObject:DisplayObject):void {
			scaledObject.scaleX = scaledObject.scaleY = 1;

			var scale:Number;

			if (scaledObject.width / scaledObject.height > stage.stageWidth / stage.stageHeight){
				scale = stage.stageHeight / scaledObject.height;
			} else {
				scale = stage.stageWidth / scaledObject.width;
			}
			
			scaledObject.scaleX = scaledObject.scaleY = scale;
			scaledObject.x = (stage.stageWidth - scaledObject.width) / 2;
			scaledObject.y = (stage.stageHeight - scaledObject.height) / 2;
		}
		
	}
}