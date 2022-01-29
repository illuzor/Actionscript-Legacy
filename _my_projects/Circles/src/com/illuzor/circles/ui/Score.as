package com.illuzor.circles.ui {
	
	import com.greensock.TweenLite;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Score extends Sprite {
		
		private var container:Sprite;
		private var scoresText:TextField;
		private var newScoresText:TextField;
		
		public function Score(text:String, color:uint, w:uint) {
			container = new Sprite();
			addChild(container);
			scoresText = new TextField(10, 10, text, "play", 120, color);
			scoresText.batchable = true;
			scoresText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			container.addChild(scoresText);
			container.width = w;
			container.scaleY = container.scaleX;
		}
		
		public function changeText(num:uint):void {
			var text:String = "";
			for (var i:int = String(num).length; i < 4; i++) {
				text += "0";
			}
			text += String(num);
			scoresText.text = text;
		}
		
		public function changeColor(color:uint):void {
			if(color != scoresText.color){
				newScoresText = new TextField(10, 10, scoresText.text, "play", 120, color);
				newScoresText.batchable = true;
				newScoresText.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
				container.addChild(newScoresText);
				newScoresText.alpha = 0;
				
				TweenLite.to(newScoresText, .25, { alpha:1 } );
				TweenLite.to(scoresText, .25, { alpha:0, onComplete:changeTextField } );
			}
		}
		
		private function changeTextField():void {
			removeChild(scoresText);
			scoresText.dispose();
			scoresText = newScoresText;
		}
		
	}
}