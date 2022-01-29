package com.illuzor.otherside.graphics.game.ships {
	
	import com.illuzor.otherside.graphics.game.HitableObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ShipBase extends HitableObject {
		
		private var _baseSpeed:uint = 7;
		public var speed:Number;
		
		public function ShipBase() {
			
		}
		
		public function get baseSpeed():uint {
			return _baseSpeed;
		}
		
	}
}