package com.illuzor.thegame.editor.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	public class TestLevelEvent extends Event {
		
		public static const RETURN_TO_EDITOR:String = "returnToEditor";
		
		public function TestLevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new TestLevelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("TestLevelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}

}