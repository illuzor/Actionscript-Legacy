package com.illuzor.toastTest {
	
	import adobe.utils.CustomActions;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.text.StageText;
	//import com.illuzor.notification.NotificationInterface;
	import flash.desktop.NativeApplication;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import com.illuzor.notification.NotificationExtention;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var textField:TextField;
		private var firstTextField:StageText;
		private var secondTextField:StageText;
		//private var stageText:StageText;
		
		//private var notification:NotificationInterface;
		
		public function Main():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			trace("start")
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			textField = new TextField();
			textField.type = TextFieldType.INPUT;
			textField.border = true;
			textField.x = 15;
			textField.y = 15;
			textField.width = stage.stageWidth - 30;
			textField.height = stage.stageHeight / 3;
			//addChild(textField);
			
			
			firstTextField = generateTextField(new Rectangle(15, 15, stage.stageWidth - 30, 80), "Enter title");
			
			secondTextField = generateTextField(new Rectangle(15, 120, stage.stageWidth - 30, 80), "Enter text")
			
			//stageText.
			//addChild(stageText);

			var toastButton:TextField = new TextField();
			toastButton.autoSize = TextFieldAutoSize.LEFT;
			toastButton.text = "Show toast";
			addChild(toastButton);
			
			toastButton.scaleX = toastButton.scaleY = 5;
			toastButton.y = textField.y + textField.height + 30;;
			toastButton.x = (stage.stageWidth - toastButton.width) / 2;
			toastButton.border = true;
			toastButton.selectable = false;
			toastButton.addEventListener(MouseEvent.CLICK, onToastClick);
			
			var notifButton:TextField = new TextField();
			notifButton.autoSize = TextFieldAutoSize.LEFT;
			notifButton.text = "Show notif";
			addChild(notifButton);
			
			notifButton.scaleX = notifButton.scaleY = 5;
			notifButton.y = toastButton.y + toastButton.height + 30;
			notifButton.x = (stage.stageWidth - notifButton.width) / 2;
			notifButton.border = true;
			notifButton.selectable = false;
			notifButton.addEventListener(MouseEvent.CLICK, onNotifClick);
			
			//notification = new NotificationInterface();
			// entry point
			//trace("Notification created")
			NotificationExtention.init();
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		private function onNotifClick(e:MouseEvent):void {
			NotificationExtention.showNotification(secondTextField.text, firstTextField.text);
			trace("show notif")
		}
		
		private function onToastClick(e:MouseEvent):void {
			trace("click");
			NotificationExtention.showToast(firstTextField.text);
			//notification.notify("Hello!")
		}
		
		private function deactivate(e:Event):void {
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
		private function generateTextField(rect:Rectangle, initialText:String):StageText {
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xD2D2D2);
			shape.graphics.drawRect(rect.x - 5, rect.y - 5, rect.width + 10, rect.height +10);
			shape.graphics.endFill();
			addChild(shape);
			
			var stageText:StageText = new StageText();
			stageText.fontSize = 25;
			stageText.stage = stage;
			stageText.editable = true;
			stageText.viewPort = rect;
			stageText.text = initialText;
			return stageText;
		}
		
	}
	
}