package {
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var tf:TextField;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			tf = new TextField();
			tf.width = stage.stageWidth;
			tf.height = 50;
			addChild(tf);
			
			tf.text = "init";
			
			var loader:Loader = new Loader();
			loader.load(new URLRequest("http://test.illuzor.com/xmlsite_12/photos/background01.jpg"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, inProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, ioError);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, ioError);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.VERIFY_ERROR, ioError);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, secur);
		}
		
		private function secur(e:SecurityErrorEvent):void {
			tf.text = "security error";
		}
		
		private function ioError(e:IOErrorEvent):void {
			tf.text = "io error";
		}
		
		private function inProgress(e:ProgressEvent):void {
			tf.text = "loading";
		}
		
		private function loaded(e:Event):void {
			addChild(e.target.content as Bitmap);
		}
		
	}
	
}