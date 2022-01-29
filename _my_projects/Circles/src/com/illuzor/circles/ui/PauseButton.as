package com.illuzor.circles.ui {
	
	import com.greensock.TweenLite;
	import com.illuzor.circles.tools.Assets;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class PauseButton extends Sprite {
		
		private var color:uint;
		private var texture:Texture;
		private var button:Button;
		private var newButton:Button;
		
		public function PauseButton(color:uint) {
			this.color = color;
			texture = Assets.atlas.getTexture("pause_button");
			button = new Button(texture);
			addChild(button);
			button.color = color;
			button.addEventListener(Event.TRIGGERED, onButtonClick);
		}

		public function changeColor(color:uint):void {
			if (this.color != color) {
				this.color = color;
				
				newButton = new Button(texture);
				addChild(newButton);
				newButton.color = color;
				newButton.alpha = 0;
				TweenLite.to(newButton, .25, { alpha:1 } );
				TweenLite.to(button, .25, { alpha:0, onComplete:changeButtons } );
			}
		}
		
		private function changeButtons():void {
			button.removeEventListener(Event.TRIGGERED, onButtonClick);
			removeChild(button);
			button.dispose();
			
			button = newButton;
			button.addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		private function onButtonClick(e:Event):void {
			dispatchEvent(new Event(Event.TRIGGERED));
		}
		
		override public function dispose():void {
			TweenLite.killTweensOf(newButton);
			TweenLite.killTweensOf(button);
			button.removeEventListener(Event.TRIGGERED, onButtonClick);
			super.dispose();
		}
		
	}
}