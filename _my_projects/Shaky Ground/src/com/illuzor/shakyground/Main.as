package com.illuzor.shakyground {
	
	import flash.Boot;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.hires.debug.Stats;
	
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
			new Boot();
			Settings.debug = true;
			
			addChild(new NapeTest());
			addChild(new Stats());
		}
		
	}
	
}