package com.illuzor.otherside.graphics.characters {
	
	import com.illuzor.otherside.constants.MovableType;
	import starling.display.Image;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Asteroid extends MovableObject {
		
		private var speed:Number;
		
		public function Asteroid(texture:Texture, speed:Number, color:uint, scale:Number ) {
			_type = MovableType.ASTEROID;
			this.speed = speed;
			var image:Image = new Image(texture);
			image.scaleX = image.scaleY = scale;
			addChild(image);
			pivotX = width >> 1;
			pivotY = height >> 1;
			image.color = color;
			
			/*var filter:ColorMatrixFilter = new ColorMatrixFilter();
			  filter.invert();
			  filter.adjustSaturation(-0.5);
			  filter.adjustHue(1.0);
			image.filter = filter;*/
			
		}
		
		override public function move():void {
			rotation += speed/100;
			y += speed;
		}
		
	}
}