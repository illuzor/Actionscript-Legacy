package com.illuzor.otherside.editor.tools {
	
	import com.illuzor.otherside.editor.errors.ResizeError;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class GlobalResizer {
		
		private static var stage:Stage;
		private static var functions:Vector.<Function>;
		private static var _stageWidth:uint;
		private static var _stageHeight:uint;
		
		public static function init(stage:Stage):void {
			GlobalResizer.stage = stage;
			functions = new Vector.<Function>();
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		public static function forceResize(resizeFunction:Function):void {
			if (!stage) {
				throw new ResizeError("Call init function before addResize");
				return;
			}
			resizeFunction(_stageWidth, _stageHeight);
		}
		
		public static function addResize(resizeFunction:Function, autoResize:Boolean = true):void {
			if(autoResize) forceResize(resizeFunction);
			functions.push(resizeFunction);
		}
		
		public static function removeResize(resizeFunction:Function):void {
			var counter:uint;
			while (counter < functions.length) {
				if (functions[counter] == resizeFunction) {
					functions.splice(counter, 1);
					break;
				}
				counter++;
			}
		}
		
		private static function onResize(e:Event = null):void {
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			if (functions.length) {
				var counter:int = functions.length-1;
				while (counter >= 0) {
					functions[counter](_stageWidth, _stageHeight);
					counter--;
				}
			}
		}
		
		public static function get stageWidth():uint {
			return _stageWidth;
		}
		
		public static function get stageHeight():uint {
			return _stageHeight;
		}
		
	}
}