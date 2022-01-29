package com.illuzor.otherside.graphics.characters {
	
	import com.illuzor.otherside.tools.ResizeManager;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ShipBase extends Sprite {
		
		protected var _baseSpeed:Number;
		protected var _speedAspect:Number = 1;
		
		public function ShipBase(config:Object = null) {
			_baseSpeed = 4.2;
		}
		
		protected function get baseSpeed():Number {
			return _baseSpeed * _speedAspect;
		}
		
		public function get speed():Number {
			return 0;
		}
		
	}
}