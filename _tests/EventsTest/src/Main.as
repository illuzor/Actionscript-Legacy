package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
	
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			
			var tf:TextField = new TextField();
			sprite.addChild(tf);
			tf.type = TextFieldType.INPUT;
			tf.border = true;
			tf.background = true;
			tf.backgroundColor = 0xC0C0C0;
			
			trace('ok');
			
			var useCapture:Boolean = false;
			
			stage.addEventListener(TextEvent.TEXT_INPUT, onTextInput, useCapture);
			sprite.addEventListener(TextEvent.TEXT_INPUT, onTextInput, useCapture);
			tf.addEventListener(TextEvent.TEXT_INPUT, onTextInput, useCapture);
		}
		
		private function onTextInput(e:TextEvent):void {
			trace(e.type, e.target, e.currentTarget);
			/*if (e.currentTarget is TextField)
				e.stopImmediatePropagation();*/
		}
		
	}
	
}