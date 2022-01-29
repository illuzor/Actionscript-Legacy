package {
	
	import flash.display.MovieClip;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.Video;
	
	public class MyCamera {
		
		private var cam:Camera;
		private var mic:Microphone;
		
		public function MyCamera():void{
			cam = Camera.getCamera();
			mic = Microphone.getMicrophone();
		}
		
		public function AttachCamera(video:Video):void {
			video.attachCamera(cam);
		}
	}
}