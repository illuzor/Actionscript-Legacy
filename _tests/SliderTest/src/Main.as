package {
	import com.bit101.components.Label;
	import com.bit101.components.Slider;
	import com.bit101.components.TextArea;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var slider:Slider;
		private var tf:TextField;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			slider = new Slider();
			slider.tick = .1
			slider.minimum = 0;
			slider.maximum = 250;
			slider.width = 100;
			slider.x = slider.y = 20;
			addChild(slider);
			
			tf = new TextField();
			addChild(tf);
			tf.text = "0"
			tf.x = 20;
			tf.y = 50;
			
			slider.addEventListener(Event.CHANGE, onChange);
			
		}
		
		private function onChange(e:Event):void {
			tf.text = String(slider.value.toFixed(2));
		}
		
	}
	
}