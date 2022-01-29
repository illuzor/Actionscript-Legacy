package com.illuzor.circles.ui {
	
	import adobe.utils.CustomActions;
	import com.greensock.TweenLite;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class LiveCircle extends Sprite {
		
		private var circle:Image;
		private var texture:Texture;
		private var newCircle:Image;
		
		public function LiveCircle(texture:Texture, color:uint) {
			this.texture = texture;
			circle = new Image(texture);
			addChild(circle);
			circle.color = color;
		}
		
		public function changeColor(color:uint):void {
			newCircle = new Image(texture);
			addChild(newCircle);
			newCircle.color = color;
			newCircle.alpha = 0;
			TweenLite.to(newCircle, .25, { alpha:1 } );
			TweenLite.to(circle, .25, { alpha:0, onComplete:changeCircles } );
		}
		
		private function changeCircles():void {
			removeChild(circle);
			circle.dispose();
			circle = newCircle;
		}
		
	}
}