package com.illuzor.otherside.graphics.characters {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class MovableObject extends HitableObject {
		
		protected var speed:Number;
		protected var _type:uint;
		
		public function move():void {
			this.y += speed;
		}
		
		public function get type():uint {
			return _type;
		}
		
	}
}