package com.illuzor.otherside.editor.events {
	
	import com.illuzor.otherside.editor.screen.gameElements.Enemy;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class EnemyEvent extends Event {

		public static const SELECTED:String = "enemySelected";
		private var _enemy:Enemy;
		
		public function EnemyEvent(type:String, enemy:Enemy) { 
			super(type, true);
			_enemy = enemy;
		} 
		
		public function get enemy():Enemy {
			return _enemy;
		}
		
	}
}