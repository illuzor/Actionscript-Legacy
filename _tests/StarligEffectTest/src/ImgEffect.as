package  {
	
	import org.libspark.betweenas3.tweens.ITween;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import com.greensock.TweenLite;
	import starling.core.Starling;
	import org.libspark.betweenas3.BetweenAS3;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class ImgEffect extends Sprite {
		
		private var imgArray:Array = [
		[0, 0, 1, 1, 1, 1, 0, 0],
		[0, 1, 1, 1, 1, 1, 1, 0],
		[1, 1, 0, 1, 1, 0, 1, 1],
		[1, 1, 1, 1, 1, 1, 1, 1],
		[0, 1, 1, 1, 1, 1, 1, 0],
		[0, 1, 1, 1, 1, 1, 1, 0],
		[0, 0, 1, 0, 0, 1, 0, 0]
		]
		
		public function ImgEffect() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			//var img:Image = new Image(Assets.pixel);
			//addChild(img);
			
			for (var i:int = 0; i < imgArray.length ; i++) {
				for (var j:int = 0; j < imgArray[i].length; j++) {
					if (imgArray[i][j] == 1) {
						var img:Image = new Image(Assets.pixel);
						img.x = j*4;
						img.y = i * 4;
						addChild(img);
					}
				}
			}
		}
	
		public function bang():void {
			/*var square:MovieClip = Assets.square;
			square.alpha = .4;
			square.fps = 120;
			Starling.juggler.add(square);
			square.x = -80 + this.width / 2;
			square.y = -80 + this.height / 2;
			square.loop = false;
			addChild(square);*/
			
			
			for (var i:int = 0; i < numChildren; i++) {
				var tempImg:Image = getChildAt(i) as Image;
				var animTime:Number = .2 + .2 * Math.random()
				//TweenLite.to(tempImg, animTime, { x:Math.random() * 200 - 100, y:Math.random() * 200 - 100 } );
				//TweenLite.to(tempImg, animTime*.6, { alpha:0, overwrite:false, delay:animTime*.4 } );
				var tween:ITween = BetweenAS3.tween(tempImg, { x:Math.random() * 200 - 100, y:Math.random() * 200 - 100 }, { x:tempImg.x, y:tempImg.y }, animTime);
				tween.play();
				
				var aTween:ITween = BetweenAS3.tween(tempImg, { alpha:0 }, { alpha:1 }, animTime * .6);
				aTween.play();
			}
		}
		
	}
}