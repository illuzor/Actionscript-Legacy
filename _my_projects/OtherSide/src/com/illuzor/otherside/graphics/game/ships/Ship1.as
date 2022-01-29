package com.illuzor.otherside.graphics.game.ships {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Ship1 extends ShipBase {
		
		public function Ship1(texture:Texture) {
			var image:Image = new Image(texture);
			addChild(image);
			speed = baseSpeed;
			pivotX = this.width >> 1;
			pivotY = this.height;
		}
		
	}
}