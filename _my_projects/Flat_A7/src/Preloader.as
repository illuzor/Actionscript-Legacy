package 
{
	import com.illuzor.framework.text.FastTextField;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author iLLuzor // illuzor.com // illuzor@gmail.com
	 * Self Preloader
	 */
	
	public class Preloader extends MovieClip {
		private var tf:FastTextField;
		
		public function Preloader() {
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			tf = new FastTextField("", 300, 40, 20, 0x4E4E4E, "center");
			tf.x = (stage.stageWidth - 300) / 2 + 5;
			tf.y = (stage.stageHeight - 40) / 2 - 110;
			addChild(tf);
		}

		private function progress(e:ProgressEvent):void {
			tf.text = String(Math.ceil(e.bytesLoaded / e.bytesTotal*100)) + "%";
		}
		
		private function checkFrame(e:Event):void {
			if (currentFrame == totalFrames) {
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void {
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			removeChild(tf);
			tf = null;
			startup();
		}
		
		private function startup():void {
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
	}
}