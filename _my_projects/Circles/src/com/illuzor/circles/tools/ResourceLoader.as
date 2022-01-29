package com.illuzor.circles.tools {
	
	import com.illuzor.circles.events.ResourceLoaderEvent;
	import com.illuzor.circles.Settings;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
		
	[Event(name = "resourcesLoader", type = "com.illuzor.circles.events.ResourceLoaderEvent")]
	
	public class ResourceLoader extends EventDispatcher{
		
		private const ATLAS_DATA_URL:String = "../assets/graphics/atlas.atf";
		private const ATLAS_XML_URL:String = "../assets/graphics/atlas.xml";
		private const FONT_URL:String = "../assets/font.fnt";
		
		private var atlasBytes:ByteArray;
		private var atlasXML:XML;
		private var _fontXML:XML;
		
		public function ResourceLoader() {
			var dataLoader:URLLoader = new URLLoader();
			dataLoader.dataFormat = URLLoaderDataFormat.BINARY;
			dataLoader.load(new URLRequest(ATLAS_DATA_URL));
			dataLoader.addEventListener(Event.COMPLETE, onDataLoaded);
		}
		
		private function onDataLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onDataLoaded);
			atlasBytes = e.target.data as ByteArray;
			
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest(ATLAS_XML_URL));
			xmlLoader.addEventListener(Event.COMPLETE, onXMLLoaded)
		}
		
		private function onXMLLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onXMLLoaded);
			atlasXML = XML(e.target.data);
			
			var fontLoader:URLLoader = new URLLoader();
			fontLoader.load(new URLRequest(FONT_URL));
			fontLoader.addEventListener(Event.COMPLETE, onFontLoaded);
		}
		
		private function onFontLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onXMLLoaded);
			_fontXML = XML(e.target.data);
			
			var langURL:String = "../assets/en.lang";
			if (Capabilities.language == "ru") {
				Settings.lang = "ru";
				langURL = "../assets/ru.lang";
			}
			
			var langLoader:URLLoader = new URLLoader();
			langLoader.load(new URLRequest(langURL));
			langLoader.addEventListener(Event.COMPLETE, onLangLoaded);
		}
		
		private function onLangLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onLangLoaded);
			Assets.lang = JSON.parse(String(e.target.data));
			dispatchEvent(new ResourceLoaderEvent(ResourceLoaderEvent.RESOURCES_LOADED));
		}
		
		public function get atlas():TextureAtlas {
			var texture:Texture = Texture.fromAtfData(atlasBytes as ByteArray, 1, false);
			var atlas:TextureAtlas = new TextureAtlas(texture, atlasXML)
			return atlas;
		}
		
		public function get fontXML():XML {
			return _fontXML;
		}
	}
}