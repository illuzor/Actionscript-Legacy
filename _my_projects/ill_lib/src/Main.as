package 
{
	import com.illuzor.display.Rotator;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		//[Embed(source = "../assets/i-2577.jpg")] private var Img:Class;
		
		[Embed(source = "../assets/rotator.png")]
		private var RotatorClass:Class;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// entry point
			
			addChild(new AtlasTest());
			
			var stats:Stats = new Stats();
			stats.x = stage.stageWidth - 100;
			addChild(stats);
			
			var rotator:Rotator = new Rotator((new RotatorClass as Bitmap).bitmapData, new Rectangle(0, 0, 32, 32));
			addChild(rotator);
			rotator.x = 200;
			
			//addChild(new Img as Bitmap);
			
			/*var tf:TextArea = new TextArea();
			tf.htmlText = "Hello <b>привет</b> 1234567890!№;%:?*()_+!@#$%^&*()";
			tf.width = tf.textWidth;
			addChild(tf);
			
			var tf1:TextField = new TextField();
			tf1.y = 30;
			tf1.text = "Hello привет";
			addChild(tf1);*/
			
			//addChild(new NotificaionButton("Hello pgdszgsgsgsdgsgq"))
			//NotificationManger.init(stage);
			//NotificationManger.addSimple("This is sample text This is sample textThis is sample textThis is sample textThis is sample textThis is sample textThis is sample textThis is sample text");
			//NotificationManger.addSimple("This is sample text 2");
			//NotificationManger.addSimple("This is sample text 3");
			
			//NotificationManger.removeAll();
			//NotificationManger.remove();
		}
		
	}
	
}