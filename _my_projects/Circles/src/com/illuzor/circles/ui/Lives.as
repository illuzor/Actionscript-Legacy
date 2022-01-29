package com.illuzor.circles.ui {
	
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import com.illuzor.circles.tools.Assets;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Lives extends Sprite {
		
		private var livesAmount:uint = 3;
		private var color:uint;
		private var initX:Vector.<uint> = new Vector.<uint>();
		
		public function Lives(color:uint) {
			this.color = color;
			var texture:Texture = Assets.atlas.getTexture("live");
			for (var i:int = 0; i < 3; i++) {
				var live:LiveCircle = new LiveCircle(texture, color);
				addChild(live);
				if (i != 0) live.x = this.width + live.width / 2;
				initX.push(live.x);
			}
		}
		
		public function changeColor(color:uint):void {
			if(color != this.color){
				this.color = color;
				for (var i:int = 0; i < numChildren; i++) {
					(getChildAt(i) as LiveCircle).changeColor(color);
				}
			}
		}
		
		public function reduce():void {
			if(livesAmount > 0){
				livesAmount--;
				var circle:LiveCircle = getChildAt(2 - livesAmount) as LiveCircle;
				var distX:uint = circle.x + circle.width / 2;
				var distY:uint = circle.y + circle.height / 2;
				TweenLite.to(circle, .4, { scaleX:0, scaleY:0, x:distX, y:distY, ease:Back.easeIn } );
			}
		}
		
		public function restart():void {
			for (var i:int = 0; i < numChildren; i++) {
				var circle:LiveCircle = getChildAt(i) as LiveCircle;
				circle.scaleX = circle.scaleY = 1;
				circle.x = initX[i];
				circle.y = 0;
			}
			livesAmount = 3;
		}
		
		public function get gameOver():Boolean {
			if (livesAmount == 0) return true;
			return false;
		}
		
	}
}