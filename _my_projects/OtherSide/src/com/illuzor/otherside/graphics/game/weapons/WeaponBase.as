package com.illuzor.otherside.graphics.game.weapons {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class WeaponBase extends Image {
		
		protected var _damage:Number;
		protected var speed:Number;
		
		public function WeaponBase(texture:Texture) {
			super(texture);
		}
		
		protected function setParams(damage:Number, speed:Number):void {
			this.speed = speed;
			_damage = damage;
			this.pivotX = this.width >> 1;
		}
		
		public function get damage():Number {
			return _damage;
		}
		
	}
}