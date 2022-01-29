package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import com.illuzor.utils.Tool;
	
	/**
	 * ...
	 * @author iLLuzor  //  illuzor@gmail.com  //  http://illuzor.com
	 */
	public class Main extends Sprite {
		private static var someText:String = "Кнопками xxx выберите вкладку xxx @Кнопками xxx выберите пункт [Язык]@(третий пункт сверху) @Затем нажмите xxx."
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.beginFill(0x000000);
			mc.graphics.drawRect(0, 0, 100, 100);
			mc.graphics.endFill();
			
			this.addChild(mc).x = Math.random() * 200;
			this.addChild(mc).y = Math.random() * 250;
			// entry point
			
			/*var tf:TextField = new TextField();
			tf.width = 300;
			tf.selectable = false;
			tf.height = 100;
			tf.multiline = true
			tf.wordWrap = true;
			tf.border = true;
			addChild(tf);
			
			Tool.animateString(tf, someText, 5000, goNext);*/
		}
		//public function goNext():void {
			//trace("next");
		//}
	}
}