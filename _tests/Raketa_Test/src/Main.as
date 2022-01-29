package {
	
	import display.Scene;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class Main extends Sprite {
		
		private var resourceManager:ResourceManager;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var loader:Loader = new Loader();
			loader.load(new URLRequest("explosion_assets.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}
		
		private function onLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onLoaded);
			ResourceManager.parse(e.target.applicationDomain);
			
			var scene:Scene = new Scene();
			addChild(scene);
			scene.x = 150;
			scene.y = 300;
		}
		
	}
}