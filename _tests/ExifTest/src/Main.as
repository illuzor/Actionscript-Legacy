package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import jp.shichiseki.exif.ExifLoader;
	import jp.shichiseki.exif.IFD;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		private var loader:ExifLoader;
		
		public function Main():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			loader = new ExifLoader();
			loader.load(new URLRequest("buttonCircleOff_main.png"));
			loader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event):void {
			if (loader.exif.ifds.primary)
				displayIFD(loader.exif.ifds.primary);
			if (loader.exif.ifds.exif)
				displayIFD(loader.exif.ifds.exif);
			if (loader.exif.ifds.gps)
				displayIFD(loader.exif.ifds.gps);
			if (loader.exif.ifds.interoperability)
				displayIFD(loader.exif.ifds.interoperability);
			if (loader.exif.ifds.thumbnail)
				displayIFD(loader.exif.ifds.thumbnail);
		}
		
		private function displayIFD(ifd:IFD):void {
			trace(" --- " + ifd.level + " --- ");
			for (var entry:String in ifd) {
				trace(entry + ": " + ifd[entry]);
			}
		
		}
	
	}
}