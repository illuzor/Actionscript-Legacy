package com.illuzor.otherside.events {
	
	import starling.events.Event;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ScreenEvent extends Event {
		
		private var _screenType:uint;
		private var _data:Object;
		
		public static const CHANGE_SCREEN:String = "changeScreen";
		public static const ERROR:String = "screenError";
		
		public function ScreenEvent(type:String, screenType:uint = 0, data:Object = null) { 
			super(type, true);
			this._data = data;
			this._screenType = screenType;
		} 
		
		public function get screenType():uint {
			return _screenType;
		}
		
		override public function get data():Object {
			return _data;
		}
		
	}
}