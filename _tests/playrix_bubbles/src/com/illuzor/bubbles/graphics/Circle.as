package com.illuzor.bubbles.graphics {
	
	import starling.textures.Texture;
	
	/**
	 * Класс круга, летающего по сцене
	 */
	
	public class Circle extends PlayerCircle {
		
		public var directionX:int;
		public var directionY:int;
		private var speedX:Number;
		private var speedY:Number;
		
		public function Circle(texture:Texture, speedX:Number, speedY:Number) {
			super(texture);
			this.speedY = speedY;
			this.speedX = speedX;
			width = height = 24;
		}
		
		public function move():void {
			this.x = this.x + directionX * speedX;
			this.y = this.y + directionY * speedY;
		}
		
	}
}