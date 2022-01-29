package com.illuzor.circles.tools {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MessageTool {
		
		private static var sprite:Sprite;
		private static var stage:Stage;
		private static var text:String;
		private static var textField:TextField;
		
		public static function showMessage(stage:Stage, text:String, cancaleble:Boolean = true):void {
			MessageTool.text = text;
			MessageTool.stage = stage;
			sprite = new Sprite();
			stage.addChild(sprite);
			
			textField = new TextField();
			textField.width = stage.stageWidth * 2;
			sprite.addChild(textField);
			textField.text = text;
			textField.mouseEnabled = false;
			textField.multiline = textField.wordWrap = true;
			
			var textFormat:TextFormat = new TextFormat(null, 30, 0xFFFFFF);
			textField.setTextFormat(textFormat);
			textField.width = textField.textWidth + 10;
			textField.height = textField.textHeight + 10;
			
			if (cancaleble) {
				sprite.addEventListener(MouseEvent.CLICK, onClick);
			}
			
			ResizeManager.addResize(resize);
		}
		
		private static function onClick(e:MouseEvent):void {
			sprite.removeEventListener(MouseEvent.CLICK, onClick);
			stage.removeChild(sprite);
			ResizeManager.removeResize(resize);
		}
		
		private static function resize(stageWidth:uint, stageHeight:uint):void{
			sprite.graphics.clear();
			sprite.graphics.beginFill(0x0, .92);
			sprite.graphics.drawRect(0, 0, stageWidth, stageHeight);
			sprite.graphics.endFill();
			textField.x = (stageWidth - textField.width) >> 1;
			textField.y = (stageHeight - textField.height) >> 1;
		}
	}
}