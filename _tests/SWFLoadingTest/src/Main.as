package {
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		
		[Embed(source = "../assets/photo.jpg")]
		private const PhotoClass:Class;
		
		public function Main():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			// new to AIR? please read *carefully* the readme.txt files!
			var photoBitmap:Bitmap = new PhotoClass() as Bitmap;
			photoBitmap.smoothing = true;
			photoBitmap.width = (stage.stageWidth - photoBitmap.width) / 2;
			photoBitmap.scaleY = photoBitmap.scaleX;
			addChild(photoBitmap);
		}
		
		private function deactivate(e:Event):void {
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}