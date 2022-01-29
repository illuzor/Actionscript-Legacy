package  {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class TheLoader extends Sprite {
		private var loader:Loader;
		
		public function TheLoader() {
			loader = new Loader();
			loader.load(new URLRequest("ToLoad.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
		}
		
		private function loaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, loaded);
			
			var LoadedClass:Class = loader.content.loaderInfo.applicationDomain.getDefinition("ToLoad") as Class;
			var newVar:ToLoad = new LoadedClass() as ToLoad;
			addChild(newVar);
			trace(newVar.toTrace);
		}
		
	}
}