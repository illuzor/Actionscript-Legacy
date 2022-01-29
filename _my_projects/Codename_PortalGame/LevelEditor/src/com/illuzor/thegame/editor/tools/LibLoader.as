package com.illuzor.thegame.editor.tools {
	
	import com.illuzor.thegame.events.LibEvent;
	import com.illuzor.thegame.tools.Assets;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	[Event(name="libLoaded", type="com.illuzor.thegame.events.LibEvent")]
	public class LibLoader extends EventDispatcher {
		
		[Embed(source="../../../../../../../Codename_PortalGame/lib/graphics.swf", mimeType="application/octet-stream")]
		private const GraphicsLib:Class;
		
		public function LibLoader() {
			var context:LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			
			var loader:Loader = new Loader();
			loader.loadBytes(new GraphicsLib(), context);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		private function onLoadComplete(e:Event):void {
			Assets.init(e.target.applicationDomain);
			dispatchEvent(new LibEvent(LibEvent.LIB_LOADED));
		}
		
	}
}