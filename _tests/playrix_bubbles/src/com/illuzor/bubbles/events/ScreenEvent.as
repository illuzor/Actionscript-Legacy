package com.illuzor.bubbles.events {
	
	import starling.events.Event;
	
	public class ScreenEvent extends Event {
		
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		private var type:String;
		private var _screenType:uint;
		
		public function ScreenEvent(type:String, screenType:uint) {
			this._screenType = screenType;
			this.type = type;
			super(type, true);
		}
		
		public function get screenType():uint {
			return _screenType;
		}
		
	}
	
}