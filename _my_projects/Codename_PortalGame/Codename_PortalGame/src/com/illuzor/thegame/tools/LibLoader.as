package com.illuzor.thegame.tools {
	
	import com.illuzor.thegame.events.LibEvent;
	import com.illuzor.thegame.tools.Assets;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	[Event(name="libLoaded", type="com.illuzor.thegame.events.LibEvent")]
	public class LibLoader extends EventDispatcher {
		
		[Embed(source="../../../../../lib/graphics.swf", mimeType="application/octet-stream")]
		private const GraphicsLib:Class;
		
		public function LibLoader() {
			var loader:Loader = new Loader();
			loader.loadBytes(new GraphicsLib());
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		private function onLoadComplete(e:Event):void {
			Assets.init(e.target.applicationDomain);
			dispatchEvent(new LibEvent(LibEvent.LIB_LOADED));
		}
		
	}
}