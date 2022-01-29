package com.illuzor.spinner.screens {
	
	import com.illuzor.spinner.errors.ScreenError;
	import com.illuzor.spinner.events.ScreenEvent;
	import com.illuzor.spinner.tools.ResizeManager;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ScreenBase extends Sprite {
		
		private var _stageWidth:uint = ResizeManager.stageWidth;
		private var _stageHeight:uint = ResizeManager.stageHeight;
		protected var _progress:Boolean;
		
		protected var hideData:Object = null;
		
		public function ScreenBase() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			start();
		}
		
		protected function start():void {
			throw new ScreenError("ScreenBase start() method must be overrided");
		}
		
		public function hide():void {
			this.touchable = false;
		}
		
		protected function dispatchHided():void {
			dispatchEvent(new ScreenEvent(ScreenEvent.SCREEN_HIDED, 0, hideData));
		}
		
		public function get stageWidth():uint {
			return _stageWidth;
		}
		
		public function get stageHeight():uint {
			return _stageHeight;
		}
		
		public function get progress():Boolean {
			return _progress;
		}
		
	}
}