package com.illuzor.thegame.editor.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com  //  illuzor@gmail.com
	 */
	
	public class SelectLevelEvent extends Event {
		
		public static const LEVEL_SELECTED:String = "levelSelected";
		public static const CANCEL:String = "cancelSelection";
		
		public function SelectLevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new SelectLevelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("SelectLevelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
}