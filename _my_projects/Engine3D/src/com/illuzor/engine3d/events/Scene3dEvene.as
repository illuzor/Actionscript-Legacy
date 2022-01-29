package com.illuzor.engine3d.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Scene3dEvene extends Event {
		
		static public const BACK_TO_MAIN_MENU:String = "backToMainMenu";
		static public const BACK_TO_MODEL_SELECTION:String = "backToModelSelection";
		
		public function Scene3dEvene(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new Scene3dEvene(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("Scene3dEvene", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
	}
}