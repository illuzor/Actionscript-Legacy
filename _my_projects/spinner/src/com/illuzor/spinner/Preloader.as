package com.illuzor.spinner {
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Preloader extends Sprite {
		
		public function Preloader() {
			if (stage) onAdded();
			else addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			load();
		}
		
		private function load():void {
			var loader:Loader = new Loader();
			loader.load(new URLRequest("game.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameLoaded);
		}
		
		private function onGameLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onGameLoaded);
			var game:DisplayObject = e.target.content as DisplayObject;
			addChild(game);
		}
		
	}
}