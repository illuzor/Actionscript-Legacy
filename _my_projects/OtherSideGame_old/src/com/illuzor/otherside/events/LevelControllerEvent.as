package com.illuzor.otherside.events {
	
	import com.illuzor.otherside.graphics.characters.Asteroid;
	import starling.events.Event;
	
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class LevelControllerEvent extends Event {
		
		public static const LEVEL_END:String = "levelEnd";
		public static const ADD_ASTEROID:String = "addAsteroid";
		public static const ADD_ENEMY:String = "addEnemy";
		
		private var _asteroid:Asteroid;
		
		public function LevelControllerEvent(type:String, asteroid:Asteroid = null) { 
			super(type);
			_asteroid = asteroid;
		} 
		
		public function get asteroid():Asteroid {
			return _asteroid;
		}
		
	}
}