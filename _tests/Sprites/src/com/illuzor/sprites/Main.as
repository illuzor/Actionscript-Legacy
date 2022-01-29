package com.illuzor.sprites{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			/*var alertFunctions:Object = {};
			alertFunctions["type"] = {"label":"label1"};
			trace(alertFunctions.type.label);
			trace(alertFunctions["type"]["label"]);
			
			alertFunctions["type"]["func"] = "functon";
			
			trace(alertFunctions["type"]["func"])*/
			
			/*
			var container:Sprite = new Sprite();
			container.addChild(new Sprite());
			container.addChild(new Sprite());
			container.addChild(new Sprite());
			container.addChild(new Sprite());
			container.addChild(new Sprite());
			addChild(container);
			trace(container.numChildren);
			
			while (container.numChildren) {
				container.removeChildAt(0);
			}
			trace(container.numChildren);*/
			
			test([3, 4, 5]);
		}
		
		private function test(... rest):void {
			trace(rest.join(","));
			trace(rest[0]);
			trace(rest[1]);
			trace(rest[2]);
		}
		
	}
	
}