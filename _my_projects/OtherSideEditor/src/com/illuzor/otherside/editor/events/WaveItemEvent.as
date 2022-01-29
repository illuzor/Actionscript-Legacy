package com.illuzor.otherside.editor.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class WaveItemEvent extends Event {
		
		public static const UP:String = "moveUp";
		public static const DOWN:String = "moveDown";
		public static const DELETE:String = "deleteItem";
		public static const SELECT:String = "selectItem";
		
		public function WaveItemEvent(type:String) { 
			super(type);
		} 
		
	}
}