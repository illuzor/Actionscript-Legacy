package com.illuzor.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author iLLuzor // http://illuzor.com // illuzor@gmail.com
	 */
	public class ToolsEvent extends Event 
	{
		public static const END:String = "end";
		
		public function ToolsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ToolsEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ToolsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}