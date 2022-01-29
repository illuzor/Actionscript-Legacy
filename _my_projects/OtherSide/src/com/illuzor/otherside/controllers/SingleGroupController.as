package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.events.LevelControllerEvent;
	import com.illuzor.otherside.graphics.game.characters.Enemy;
	import com.illuzor.otherside.utils.MegaTimer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class SingleGroupController extends EventDispatcher {
		
		private var enemiesTimer:MegaTimer;
		private var groupData:Object;
		private var curves:Object;
		private var textures:Dictionary;
		
		public function SingleGroupController(groupData:Object, curves:Object, textures:Dictionary) {
			this.textures = textures;
			this.curves = curves;
			this.groupData = groupData;
			enemiesTimer = new MegaTimer(groupData.enemiesDelay * 1000, groupData.enemies.length);
			enemiesTimer.start();
			enemiesTimer.addEventListener(TimerEvent.TIMER, onEnemiesTimerEvent);
			enemiesTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onEnemiesTimerEvent);
		}
		
		private function onEnemiesTimerEvent(e:TimerEvent):void {
			var enemyCount:uint = enemiesTimer.currentCount - 1;
			var enemy:Enemy = new Enemy(textures[groupData.enemies[enemyCount].skin], new Point(groupData.enemies[enemyCount].x, groupData.enemies[enemyCount].y), curves[groupData.curve].x, curves[groupData.curve].y);
			enemy.x = curves[groupData.curve].x[0];
			enemy.y = curves[groupData.curve].y[0];
			
			enemy.color = groupData.enemies[enemyCount].color;
			dispatchEvent(new LevelControllerEvent(LevelControllerEvent.ADD_ENEMY, enemy));
			if (e.type == TimerEvent.TIMER_COMPLETE) {
				enemiesTimer.removeEventListener(TimerEvent.TIMER, onEnemiesTimerEvent);
				enemiesTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onEnemiesTimerEvent);
				enemiesTimer = null;
				dispatchEvent(new LevelControllerEvent(LevelControllerEvent.GROUP_COMPLETE));
			}
		}
		
		public function pause():void {
			enemiesTimer.pause();
		}
		
		public function play():void {
			enemiesTimer.start();
		}
		
		public function dispose():void {
			if (enemiesTimer) {
				enemiesTimer.dispose();
				enemiesTimer.removeEventListener(TimerEvent.TIMER, onEnemiesTimerEvent);
				enemiesTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onEnemiesTimerEvent);
				enemiesTimer = null;
			}
			groupData = null;
			groupData = null;
			curves = null;
		}
	
	}
}