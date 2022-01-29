package com.illuzor.otherside.events {
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ControlManagerEvent extends Event {
		
		public static const MOVE_PLAYER:String = "moveThePlayer";
		
		private var _playerMove:uint;
		
		public function ControlManagerEvent(type:String, playerMove:uint) { 
			super(type);
			_playerMove = playerMove;
		} 
		
		public function get playerMove():uint {
			return _playerMove;
		}
		
	}
}