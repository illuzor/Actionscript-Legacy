package com.illuzor.bubbles.graphics {
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Класс круга игрока
	 */
	
	public class PlayerCircle extends Image {
		
		public function PlayerCircle(texture:Texture) {
			super(texture);
			pivotX = width >> 1;
			pivotY = height >> 1;
		}
		
	}
}