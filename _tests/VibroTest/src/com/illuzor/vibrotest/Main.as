package com.illuzor.vibrotest {
	
	import com.adobe.nativeExtensions.Vibration;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var vibration:Vibration;
		
		public function Main():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			var textButton:TextField = new TextField();
			textButton.autoSize = TextFieldAutoSize.LEFT;
			textButton.text = "ShowMessage";
			addChild(textButton);
			
			textButton.scaleX = textButton.scaleY = 5;
			textButton.y = 100;
			textButton.x = (stage.stageWidth - textButton.width) / 2;
			textButton.border = true;
			textButton.selectable = false;
			textButton.addEventListener(MouseEvent.CLICK, onClick);
			
			vibration = new Vibration();
		}
		
		private function onClick(e:MouseEvent):void {
			trace("click");
			if (Vibration.isSupported) vibration.vibrate(200);
		}
		
		private function deactivate(e:Event):void {
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}