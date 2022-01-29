package com.illuzor.circles.tools {
	
	import com.distriqt.extension.vibration.Vibration;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class VibroManager {
		
		private static var _isSupported:Boolean;
		
		public static function init():void {
			Vibration.init(Assets.distriqrKey);
			_isSupported = Vibration.isSupported;
			if (!_isSupported) 
				Vibration.service.dispose();
		}
		
		public static function vibrate(duration:uint):void {
			if (_isSupported) 
				Vibration.service.vibrate(duration);
		}
		
		public static function get isSupported():Boolean {
			return _isSupported;
		}
		
	}
}