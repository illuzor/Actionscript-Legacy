package com.illuzor.otherside.tools {
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 *  * 1800x1200 ---> 2048х1365
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class ResizeManager {
		
		private static var _stage:Stage;
		private static var _stageWidth:uint;
		private static var _stageHeight:uint;
		private static var _scale:Number;
		private static var _gameRectangle:Rectangle;
		private static var functions:Vector.<Function>;
		
		public static function init(stage:Stage):void {
			ResizeManager._stage = stage;
			functions = new Vector.<Function>();
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		public static function forceResize(resizeFunction:Function):void {
			if (!_stage) {
				throw new Error("Call init function before addResize");
				return;
			}
			resizeFunction(_stageWidth, _stageHeight);
		}
		
		public static function addResize(resizeFunction:Function, autoResize:Boolean = true):void {
			if(autoResize) forceResize(resizeFunction);
			functions.push(resizeFunction);
		}
		
		public static function removeResize(resizeFunction:Function):void {
			functions.splice(functions.indexOf(resizeFunction), 1)
		}
		
		private static function onResize(e:Event = null):void {
			_stageWidth = _stage.stageWidth;
			_stageHeight = _stage.stageHeight;
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
		
		public static function get scale():Number {
			return _scale;
		}
		
		public static function get stage():Stage {
			return _stage;
		}
		
	}
}