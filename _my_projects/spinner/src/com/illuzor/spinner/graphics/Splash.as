package com.illuzor.spinner.graphics {
	
	import com.greensock.TweenLite;
	import com.illuzor.spinner.utils.intRandom;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Splash extends Sprite {
		
		private const TOTAL_CIRCLES:uint = 12;
		
		private var _color:uint;
		private var circles:Vector.<Image> = new Vector.<Image>();
		private var stageWidth:uint;
		private var topStageHeight:uint;
		
		public function Splash(texture:Texture, iniSize:uint, stageWidth:uint, topStageHeight:uint) {
			this.topStageHeight = topStageHeight;
			this.stageWidth = stageWidth;
			this.touchable = false;
			for (var i:int = 0; i < TOTAL_CIRCLES; i++) {
				var circle:Image = new Image(texture);
				circle.visible = false;
				addChild(circle);
				circles.push(circle);
				var size:Number = Math.random() * iniSize * .65;
				if (size < iniSize * .2) size = iniSize * .2;
				circle.width = circle.height = size;
				circle.pivotX = circle.width / 2;
				circle.pivotY = circle.height / 2;
			}
		}
		
		public function splash():void {
			reset();
			var count:uint = intRandom(TOTAL_CIRCLES-5, TOTAL_CIRCLES);
			for (var i:int = 0; i < count; i++) {
				var destY:int = -Math.random() * topStageHeight - topStageHeight * .2;
				if (destY < -topStageHeight + 20) destY = -topStageHeight + 20;
				var destX:int = Math.random() * stageWidth - stageWidth / 2;
				var circle:Image = circles[i];
				circle.visible = true;
				circle.color = _color;
				
				var time:Number = .3 + Math.random() * .2;
				
				TweenLite.to(circle, time, { x:destX, y:destY } );
				TweenLite.to(circle, .21, { alpha:0, overwrite:false, delay:time-.21 } );
			}
		}
		
		private function reset():void {
			for (var i:int = 0; i < circles.length; i++) {
				var circle:Image = circles[i];
				TweenLite.killTweensOf(circle);
				circle.x = circle.y = 0;
				circle.visible = false;
				circle.alpha = 1;
			}
		}
		
		public function set color(value:uint):void {
			_color = value;
		}
		
		override public function dispose():void {
			reset();
			circles = null;
			super.dispose();
		}
		
	}
}