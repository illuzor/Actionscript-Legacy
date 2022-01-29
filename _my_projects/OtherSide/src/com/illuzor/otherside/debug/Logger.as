package com.illuzor.otherside.debug {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class Logger {
		
		private static var logString:String = "";
		private static var stage:Stage;
		private static var stageWidth:uint;
		private static var stageHeight:uint;
		private static var container:Sprite;
		private static var timer:Timer;
		private static var closeButton:Sprite;
		private static var textContainer:Sprite;
		
		public static function init(stage:Stage):void {
			Logger.stage = stage;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
		}
		
		public static function appendString(string:String):void {
			if (logString == "") logString = " " + string;
			else logString += "\n" + "  " + string;
		}
		
		private static function onMouseEvent(e:MouseEvent):void {
			switch (e.type) {
			case MouseEvent.MOUSE_DOWN: 
				if (!container && stage.mouseX > stage.stageWidth / 3 && stage.mouseX < stage.stageWidth - stage.stageWidth / 3 && stage.mouseY < stage.stageHeight / 3) {
					timer = new Timer(3000, 1);
					timer.start();
					timer.addEventListener(TimerEvent.TIMER, onTimer);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
				}
			break;
			
			case MouseEvent.MOUSE_UP: 
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
				disableTimer();
			break;
			
			case MouseEvent.MOUSE_MOVE: 
				if (!container) {
					if (!(stage.mouseX > stage.stageWidth / 3 && stage.mouseX < stage.stageWidth - stage.stageWidth / 3 && stage.mouseY < stage.stageHeight / 3)) {
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
						disableTimer();
					}
				}
			break;
			}
		}
		
		private static function onTimer(e:TimerEvent):void {
			disableTimer();
			Starling.current.stage.getChildAt(0).touchable = false;
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			container = new Sprite();
			container.graphics.beginFill(0xFFFFFF, .88);
			container.graphics.drawRect(0, 0, stageWidth, stageHeight);
			container.graphics.endFill();
			stage.addChild(container);
			
			closeButton = new Sprite();
			closeButton.buttonMode = true;
			stage.addChild(closeButton);
			closeButton.graphics.beginFill(0x400000);
			closeButton.graphics.drawRect(0, 0, 120, 120);
			closeButton.graphics.endFill();
			
			var cross:Shape = new Shape();
			cross.graphics.lineStyle(6, 0xFF0000);
			cross.graphics.moveTo(20, 20);
			cross.graphics.lineTo(100, 100);
			cross.graphics.moveTo(20, 100);
			cross.graphics.lineTo(100, 20);
			closeButton.addChild(cross);
			closeButton.alpha = .7;
			closeButton.scaleX = closeButton.scaleY = .72;
			closeButton.x = stageWidth - 20 - closeButton.width;
			closeButton.y = 20;
			
			textContainer = new Sprite();
			container.addChild(textContainer);
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 26;
			
			var textField:TextField = new TextField();
			textField.mouseEnabled = false;
			textField.text = logString;
			textField.x = 0
			textField.y = 20;
			textField.setTextFormat(textFormat);
			textField.multiline = true;
			textField.wordWrap = true;
			textContainer.addChild(textField);
			
			textField.width = stageWidth - 40;
			textField.height = textField.textHeight + 50;
			
			closeButton.addEventListener(MouseEvent.CLICK, onCrossClick);
			
			if (container.height > stageHeight) {
				container.addEventListener(MouseEvent.MOUSE_DOWN, onContainerMouseEvent);
				container.addEventListener(MouseEvent.MOUSE_UP, onContainerMouseEvent);
			}
		}
		
		private static function onContainerMouseEvent(e:MouseEvent):void {
			if (e.type == MouseEvent.MOUSE_DOWN) {
				textContainer.startDrag(false, new Rectangle(0, 0, 0, stageHeight - textContainer.height));
			} else {
				textContainer.stopDrag();
			}
		}
		
		private static function onCrossClick(e:MouseEvent):void {
			container.removeEventListener(MouseEvent.MOUSE_DOWN, onContainerMouseEvent);
			container.removeEventListener(MouseEvent.MOUSE_UP, onContainerMouseEvent);
			closeButton.removeEventListener(MouseEvent.CLICK, onCrossClick);
			stage.removeChild(container);
			stage.removeChild(closeButton);
			container = null;
			Starling.current.stage.getChildAt(0).touchable = true;
		}
		
		private static function disableTimer():void {
			if (timer) {
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer.stop();
				timer = null;
			}
		}
		
		public static function isEnabled():Boolean {
			return stage != null;
		}
	
	}
}