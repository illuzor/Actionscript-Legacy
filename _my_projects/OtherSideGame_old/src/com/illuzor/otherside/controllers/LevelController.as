package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.events.LevelControllerEvent;
	import com.illuzor.otherside.graphics.characters.Asteroid;
	import com.illuzor.otherside.interfaces.ILevelController;
	import com.illuzor.otherside.utils.intRandom;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class LevelController extends LevelControllerBase implements ILevelController {
		
		private var started:Boolean;
		private var currentWave:Object;
		private var wavesList:Vector.<Object>;
		private var asteroids:Vector.<Asteroid>;
		private var asteroidsTimer:Timer;
		
		public function LevelController(levelConfig:Object, atlas:TextureAtlas) {
			super(levelConfig, atlas);
			wavesList = new Vector.<Object>();
			for (var i:int = 0; i < levelConfig.waves.length; i++) {
				wavesList.push(levelConfig.waves[i]);
			}
		}
		
		private function nextWave():void {
			if (asteroids) asteroids = null;
			if (wavesList.length > 0) {
				currentWave = wavesList[0];
				wavesList.splice(0, 1);
				
				var object:Object = prepareWave();
				if (object.asteroids) {
					asteroidsTimer = new Timer(currentWave.delay*1000);
					asteroidsTimer.addEventListener(TimerEvent.TIMER, onAsteroidsTimer);
					asteroidsTimer.start();
				}
			} else {
				trace("level ends");
			}
		}
		
		private function prepareWave():Object {
			var object:Object = { asteroids:false, enemies:false };
			if (currentWave.hasOwnProperty("asteroids")) {
				makeAsteroids();
			}
			
			if (currentWave.hasOwnProperty("enemies")) {
				makeEnemies();
			}
			return object;
		}
		
		private function onAsteroidsTimer(e:TimerEvent):void {
			if (asteroidsTimer.delay != currentWave.asteroids.delay * 1000)
				asteroidsTimer.delay = currentWave.asteroids.delay * 1000;
				
			var randomNum:uint = intRandom(0, asteroids.length-1);
			var asteroid:Asteroid = asteroids[randomNum];
			asteroids.splice(randomNum, 1);
			dispatchEvent(new LevelControllerEvent(LevelControllerEvent.ADD_ASTEROID, asteroid));
			if (!asteroids.length) {
				trace("wave end");
				asteroidsTimer.removeEventListener(TimerEvent.TIMER, onAsteroidsTimer);
				asteroidsTimer.stop();
				if (wavesList.length) {
					nextWave();
				} else {
					trace("level end");
				}
			}
		}
		
		private function makeAsteroids():void {
			var types:Array = currentWave.asteroids.types;
			asteroids = new Vector.<Asteroid>();
			for (var i:int = 0; i < currentWave.asteroids.amount; i++) {
				var asteroid:Asteroid = new Asteroid(getAsteroidTexture(types[intRandom(0, types.length - 1)]), currentWave.asteroids.minSpeed, currentWave.asteroids.color, scale);
				asteroids.push(asteroid);
			}
			//object.asteroids = true;
		}
		
		private function makeEnemies():void {
			trace("enemies exists")
			//prepareWaveEnemies();
			//object.enemies = true;
		}
		
		public function play():void {
			if (!started) {
				started = true;
				nextWave();
			}
		}
		
		public function pause():void {
			
		}
		
		override public function dispose():void {
			super.dispose();
		}

	}
}