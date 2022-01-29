package  
{
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.events.MouseEvent;
	
	public class Main1 extends Sprite {
		
		private var myCamera:MyCamera;
		private var video:Video;
		
		public function Main1() {
			myCamera = new MyCamera();
			video = new Video();
			addChild(video);
			
			
			stage.addEventListener(MouseEvent.CLICK, attachMyCamera);
		}
		
		private function attachMyCamera(e:MouseEvent):void {
			myCamera.AttachCamera(video);
		}
	}
}