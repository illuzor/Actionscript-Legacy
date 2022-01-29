package com.illuzor.otherside.events {
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class ScreenEvent extends Event {
		
		private var _screenType:uint;
		private var _data:Object;
		
		public static const SCREEN_READY:String = "screenReady";
		public static const CHANGE_SCREEN:String = "changeScreen";
		public static const SCREEN_ERROR:String = "screenError";
		
		public function ScreenEvent(type:String, screenType:uint = 1242, data:Object = null) { 
			_data = data;
			_screenType = screenType;
			super(type, true);
		} 
		
		public function get screenType():uint {
			return _screenType;
		}
		
		override public function get data():Object {
			return _data;
		}
		
	}
}