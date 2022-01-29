package com.illuzor.engine3d {
	
	import com.illuzor.engine3d.notifications.NotificationManager;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Preloader extends MovieClip {
		
		public function Preloader() {
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			NotificationManager.init(stage);
			NotificationManager.addWaitingMessage("loading application...");
		}
		
		private function ioError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		private function checkFrame(e:Event):void {
			if (currentFrame == totalFrames) {
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void {
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			NotificationManager.removeWaitingMessage();
			
			startup();
		}
		
		private function startup():void {
			var mainClass:Class = getDefinitionByName("com.illuzor.engine3d.Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
}