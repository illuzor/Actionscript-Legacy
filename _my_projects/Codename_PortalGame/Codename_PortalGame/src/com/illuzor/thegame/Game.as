package com.illuzor.thegame {
	
	import com.illuzor.thegame.world.Level;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import com.illuzor.thegame.tools.LevelManager;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class Game extends Engine {
		
		public function Game() {
			super(800, 600);
		}
		
		override public function init():void {
			var level:Level = new Level(LevelManager.getLevel(1));
			FP.world = level;
			FP.console.enable();
		}
		
	}
}