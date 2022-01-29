package com.illuzor.camera {
	
	import flash.display.Sprite;
	import flash.media.Camera
	import flash.media.Video;
	import flash.system.SecurityPanel;
    import flash.system.Security;
	import flash.events.StatusEvent
	
	/**
	 * ...
	 * @author illuzor // illuzor@gmail.com // illuzor.com
	 */
	public class CameraScreen extends Sprite {
		
		private var camera:Camera;
		
		public function CameraScreen() {
			
			camera = Camera.getCamera();
			camera.setQuality(0, 80);
			Security.showSettings(SecurityPanel.PRIVACY);

			var video:Video = new Video(512, 384);
			video.attachCamera(camera);
			video.smoothing = true;
			addChild(video);
		}
		
	}
}