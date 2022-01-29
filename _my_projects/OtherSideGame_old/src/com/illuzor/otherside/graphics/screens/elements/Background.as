package com.illuzor.otherside.graphics.screens.elements {
	
	import com.illuzor.otherside.utils.*;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Background extends Sprite {
		
		private const SPEED:Number = .65;
		private var centerSpeed:Number;
		private var forwardSpeed:Number;
		private var stageWidth:uint;
		private var stageHeight:uint;
		private var textures:Vector.<Texture>;
		private var backgroundContainer:Sprite;
		private var centerContainer:Sprite;
		private var forwardContainer:Sprite;

		public function Background(w:uint, h:uint, textures:Vector.<Texture>) {
			this.textures = textures;
			this.stageHeight = h;
			this.stageWidth = w;
			centerSpeed = SPEED * 1.12;
			forwardSpeed = SPEED * 1.25;

			backgroundContainer = new Sprite();
			addChild(backgroundContainer);
			
			var backBackround1:Sprite = new Sprite();
			backgroundContainer.addChild(backBackround1);
			
			var backBackround2:Sprite = new Sprite();
			backgroundContainer.addChild(backBackround2);
			
			fillBackground(backBackround1, backBackround2, 200);
			
			
			centerContainer = new Sprite();
			addChild(centerContainer);
			
			var centerBackround1:Sprite = new Sprite();
			centerContainer.addChild(centerBackround1);
			
			var centerBackround2:Sprite = new Sprite();
			centerContainer.addChild(centerBackround2);
			
			fillBackground(centerBackround1, centerBackround2, 80);
			
			
			forwardContainer = new Sprite();
			addChild(forwardContainer);
			
			var forwardBackround1:Sprite = new Sprite();
			forwardContainer.addChild(forwardBackround1);
			
			var forwardBackround2:Sprite = new Sprite();
			forwardContainer.addChild(forwardBackround2);
			
			fillBackground(forwardBackround1, forwardBackround2, 30);
		}
		
		[Inline]
		private final function fillBackground(back1:Sprite, back2:Sprite, amount:uint):void {
			back1.y = -stageHeight << 1;
			back2.y = -stageHeight * 5;
			for (var i:int = 0; i < amount; i++) {
				
				var starX:uint = uint(stageWidth * Math.random());
				var starY:uint = uint((stageHeight*3) * Math.random());
				var starTexture:Texture = textures[intRandom(0, textures.length - 1)];
				
				var star1:Image = new Image(starTexture);
				star1.x = starX;
				star1.y = starY;
				
				var star2:Image = new Image(starTexture);
				star2.x = starX;
				star2.y = starY;
				back1.addChild(star1);
				back2.addChild(star2);
			}
		}

		public function move():void {
			backgroundContainer.y += SPEED;
			if (backgroundContainer.y >= stageHeight * 3) {
				backgroundContainer.y = 0;
			}
			
			centerContainer.y += centerSpeed;
			if (centerContainer.y >= stageHeight * 3) {
				centerContainer.y = 0;
			}
			
			forwardContainer.y += forwardSpeed;
			if (forwardContainer.y >= stageHeight * 3) {
				forwardContainer.y = 0;
			}
		}
		
	}
}