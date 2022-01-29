package com.illuzor.camera {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class DebugPanel {
		
		private static var stage:Stage;
		static private var sprite:Sprite;
		static private var textField:TextField;
		static private var timer:Timer;
		
		public static function init(stage:Stage):void {
			DebugPanel.stage = stage;
			sprite = new Sprite();
			sprite.alpha = .8;
			sprite.visible = false;
			stage.addChild(sprite)
			drawSprite();
			
			var tf:TextFormat = new TextFormat();
			tf.size = 20;
			
			textField = new TextField();
			textField.defaultTextFormat = tf;
			textField.wordWrap = true;
			textField.multiline = true;
			sprite.addChild(textField);
			textField.width = stage.stageWidth;
			textField.height = stage.stageHeight;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageUp);
			sprite.addEventListener(MouseEvent.CLICK, onSpriteClick);
			
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		
		static private function onSpriteClick(e:MouseEvent):void {
			sprite.visible = false;
		}
		
		static private function onStageDown(e:MouseEvent):void {
			trace("1")
			if (sprite.visible == false) {
				trace("2")
				if(timer != null)timer.stop();
				timer = new Timer(2500, 1);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, onTimer);
			}
		}
		
		static private function onTimer(e:TimerEvent):void {
			trace("timer")
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			sprite.visible = true;
		}
		
		static private function onStageUp(e:MouseEvent):void {
			if (timer != null) {
				trace("timer stop")
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
			}
		}
		
		static private function onResize(e:Event):void {
			drawSprite();
			textField.width = stage.stageWidth;
			textField.height = stage.stageHeight;
		}
		
		private static function drawSprite():void {
			sprite.graphics.clear();
			sprite.graphics.beginFill(0xFFFFFF);
			sprite.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			sprite.graphics.endFill();
		}
		
		public static function addText(text:String):void {
			if (textField.text == "") {
				textField.text = text;
			} else {
				//textField.text += "\n" + text;
				textField.appendText("\n" + text);
			}
		}
		
	}

}