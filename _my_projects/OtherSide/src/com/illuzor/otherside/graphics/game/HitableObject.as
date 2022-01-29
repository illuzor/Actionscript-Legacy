package com.illuzor.otherside.graphics.game {
	
	import flash.utils.setTimeout;
	import starling.display.Sprite;
	import starling.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class HitableObject extends Sprite {
		
		private const FLASH_TIME:uint = 120;
		
		private static var makeWhiteFilter:ColorMatrixFilter;
		
		public function HitableObject() {
			if (!HitableObject.makeWhiteFilter) HitableObject.initFilter();
		}
		
		public function hit():void {
			this.filter = HitableObject.makeWhiteFilter;
			setTimeout(revertFilter, FLASH_TIME);
		}
		
		private function revertFilter():void {
			this.filter = null;
		}
		
		[Inline]
		private static function initFilter():void {
			HitableObject.makeWhiteFilter = new ColorMatrixFilter();
			HitableObject.makeWhiteFilter.adjustBrightness(1);
		}
		
	}
}