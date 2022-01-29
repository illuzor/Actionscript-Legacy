package com.illuzor.otherside.screens {
	
	import com.illuzor.otherside.constants.AtlasType;
	import com.illuzor.otherside.constants.WeaponType;
	import com.illuzor.otherside.controllers.ControlManager;
	import com.illuzor.otherside.controllers.LevelController;
	import com.illuzor.otherside.controllers.resource.ResourceManager;
	import com.illuzor.otherside.controllers.WeaponController;
	import com.illuzor.otherside.debug.log;
	import com.illuzor.otherside.events.ControlManagerEvent;
	import com.illuzor.otherside.events.LevelControllerEvent;
	import com.illuzor.otherside.events.WeaponEvent;
	import com.illuzor.otherside.graphics.game.characters.Enemy;
	import com.illuzor.otherside.graphics.game.GameBackground;
	import com.illuzor.otherside.graphics.game.ships.Ship1;
	import com.illuzor.otherside.graphics.game.ships.ShipBase;
	import com.illuzor.otherside.graphics.game.weapons.Gun;
	import com.illuzor.otherside.graphics.game.weapons.WeaponBase;
	import com.illuzor.otherside.interfaces.IMovable;
	import com.illuzor.otherside.utils.MegaTimer;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.deg2rad;
	
	/**
	 * 2048x1280
	 * 
	 * @author illuzor  //  illuzor.com
	 */
	
	public class GameScreen extends ScreenBase {
		
		// vectors
		private var movablesToRemove:Vector.<IMovable> = new Vector.<IMovable>();
		private var movables:Vector.<IMovable> = new Vector.<IMovable>();
		private var bullets:Vector.<WeaponBase> = new Vector.<WeaponBase>();
		private var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		
		// controllers
		private var controlManager:ControlManager;
		private var weaponController:WeaponController;
		private var levelController:LevelController;
		
		// atlasses
		private var atlas:TextureAtlas;
		private var asteroidsAtlas:TextureAtlas;
		
		// graphics, containers
		private var container:Sprite;
		private var background:GameBackground;
		private var ship:ShipBase;
		
		
		// values, configs
		private var containerRect:Rectangle = new Rectangle(0, 0, 2048, 1280);
		private var gameConfig:Object;
		private var shipCurrentSpeed:Number = 0;
		private var shipSpeed:Number;
		private var leftShipBound:int;
		private var rightShipBound:uint;
		private var movablesRemoveCounter:uint;
		
		private var enemiesMoveTimer:Timer;
		
		public function GameScreen(gameConfig:Object) {
			this.gameConfig = gameConfig;
		}
		
		override protected function init():void {
			atlas = ResourceManager.controller.getAtlas(AtlasType.ATLAS_1);
			asteroidsAtlas = ResourceManager.controller.getAtlas(AtlasType.ASTERIODS_ATLAS);
			makeContainer();
			
			background = new GameBackground(stageWidth, stageHeight, new < Texture > [atlas.getTexture("star1"), atlas.getTexture("star2"), 
				atlas.getTexture("star3"), atlas.getTexture("star4"), atlas.getTexture("star5")]);
			addChildAt(background, 0);
			
			ship = new Ship1(atlas.getTexture("ship1"));
			shipSpeed = ship.speed;
			addToContainer(ship);
			ship.x = containerRect.width >> 1;
			ship.y = containerRect.height;
			
			
			// temp
			for (var i:int = 0; i < 5; i++) {
				var image:Image = new Image(asteroidsAtlas.getTexture("asteroid_medium1_type1"))
				addToContainer(image);
				image.color = 0xFFFFFF * Math.random();
				image.x = i * image.width;
				image.rotation = deg2rad(Math.random() * 40);
				image.scale = Math.random();
			}
			// temp
			
			controlManager = new ControlManager();
			weaponController = new WeaponController(gameConfig.weapons);
			levelController = new LevelController(gameConfig.level);
			//enemiesMoveTimer = new Timer(1000/200);
			//enemiesMoveTimer.addEventListener(TimerEvent.TIMER, onEnemiesTimer);
			
			
			dispatchReady();
		}
		
		override public function start():void {
			addEventListener(Event.ENTER_FRAME, onUpdate);
			controlManager.addEventListener(ControlManagerEvent.LEFT, onPlayerMove);
			controlManager.addEventListener(ControlManagerEvent.RIGHT, onPlayerMove);
			controlManager.addEventListener(ControlManagerEvent.STOP, onPlayerMove);
			levelController.addEventListener(LevelControllerEvent.ADD_ENEMY, onLevelControllerEvent);
			weaponController.addEventListener(WeaponEvent.SHOOT, onShoot);
			
			weaponController.play();
			levelController.next();
			//enemiesMoveTimer.start();
			
		}
		
		private function onLevelControllerEvent(e:LevelControllerEvent):void {
			switch (e.type) {
				case LevelControllerEvent.ADD_ENEMY:
					enemies.push(e.enemy);
					movables.push(e.enemy)
					addToContainer(e.enemy);
				break;
			}
		}
		
		override public function pause():void {
			trace("game pause")
			removeEventListener(Event.ENTER_FRAME, onUpdate);
			weaponController.pause();
			levelController.pause();
			//enemiesMoveTimer.stop();
		}
		
		override public function resume():void {
			trace("game resume")
			addEventListener(Event.ENTER_FRAME, onUpdate);
			weaponController.play();
			levelController.play();
			//enemiesMoveTimer.start();
		}
		
		private function onShoot(e:WeaponEvent):void {
			var weapon:WeaponBase;
			switch (e.weaponType) {
				case WeaponType.GUN:
					weapon = new Gun(atlas.getTexture("bullet1"));
					movables.push(weapon);
					bullets.push(weapon);
					addToContainerAt(weapon, 0);
					weapon.x = ship.x;
					weapon.y = ship.y;
				break;
			}
			weapon.x = ship.x + e.x;
			weapon.y = ship.y + e.y;
		}
		
		private function onPlayerMove(e:ControlManagerEvent):void {
			switch (e.type) {
				case ControlManagerEvent.LEFT:
					shipCurrentSpeed = -shipSpeed;
				break;
				case ControlManagerEvent.RIGHT:
					shipCurrentSpeed = shipSpeed;
				break;
				case ControlManagerEvent.STOP:
					shipCurrentSpeed = 0;
				break;
			}
		}
		
		private function onEnemiesTimer(e:TimerEvent):void {
			trace("enemies timer")
			for (var i:int = 0; i < enemies.length; i++) {
				enemies[i].move();
			}
			
		}
		
		private function onUpdate(e:Event):void {
			background.update();
			if (movables.length) {
				for (var i:int = 0; i < movables.length; i++) {
					movables[i].move();
				}
			}
			
			if (shipCurrentSpeed != 0) {
				var playerMoveTo:int = ship.x + shipCurrentSpeed;
				if (playerMoveTo < leftShipBound) playerMoveTo = leftShipBound;
				if (playerMoveTo > rightShipBound) playerMoveTo = rightShipBound;
				if (ship.x != playerMoveTo) ship.x = playerMoveTo;
			}
			
			for (var j:int = 0; j < bullets.length; j++) {
				var bullet:WeaponBase = bullets[j];
				if (bullet.y < 0) {
					movablesToRemove.push(bullet);
				}
			}
			
			movablesRemoveCounter++;
			
			if (movablesRemoveCounter == 200) {
				for (var k:int = 0; k < movablesToRemove.length; k++) {
					var movable:IMovable = movablesToRemove[k];
					for (var l:int = 0; l < movables.length; l++) {
						if (movables[l] == movable)
							movables.removeAt(l);
					}
					
					for (var m:int = 0; m < bullets.length; m++) {
						if (bullets[m] == movable)
							bullets.removeAt(m);
					}
					container.removeChild(movable as DisplayObject);
					(movable as DisplayObject).dispose();
				}
				movablesToRemove = new Vector.<IMovable>();
				movablesRemoveCounter = 0;
			}
		}
		
		private function makeContainer():void {
			container = new Sprite();
			addChild(container);
			var markerTexture:Texture = atlas.getTexture("marker");
			
			var topLeft:Image = new Image(markerTexture);
			container.addChild(topLeft);
			
			var topRight:Image = new Image(markerTexture);
			topRight.x = 2047;
			container.addChild(topRight);
			
			var bottomLeft:Image = new Image(markerTexture);
			bottomLeft.y = 1279;
			container.addChild(bottomLeft);
			
			var bottomRight:Image = new Image(markerTexture);
			bottomRight.x = 2047;
			bottomRight.y = 1279;
			container.addChild(bottomRight);
			
			topLeft.visible = topRight.visible = bottomLeft.visible = bottomRight.visible = false;
			topLeft.touchable = topRight.touchable = bottomLeft.touchable = bottomRight.touchable = false;
			
			container.height = stageHeight;
			container.scaleX = container.scaleY;
			container.x = (stageWidth - container.width) >> 1;
			container.y = (stageHeight - container.height) >> 1;
			
			if (container.x < 0) {
				container.width = stageWidth;
				container.scaleY = container.scaleX;
				container.x = (stageWidth - container.width) >> 1;
				container.y = (stageHeight - container.height) >> 1;
			}
				
			if (container.width < stageWidth) {
				var gapSize:uint = (stageWidth - container.width) / 2 / container.scale;
				leftShipBound = -gapSize;
				rightShipBound = containerRect.width + gapSize;
			} else {
				leftShipBound = 0;
				rightShipBound = containerRect.width;
			}
		}
		
		private function addToContainer(child:DisplayObject):void {
			container.addChild(child);
		}
		
		private function addToContainerAt(child:DisplayObject, index:int):void {
			container.addChildAt(child, index);
		}
		
		override public function back():void {
			
		}
		
		override protected function clear():void {
			removeEventListener(Event.ENTER_FRAME, onUpdate);
			controlManager.removeEventListener(ControlManagerEvent.LEFT, onPlayerMove);
			controlManager.removeEventListener(ControlManagerEvent.RIGHT, onPlayerMove);
			controlManager.removeEventListener(ControlManagerEvent.STOP, onPlayerMove);
			controlManager.dispose();
			
			//enemiesMoveTimer.removeEventListener(TimerEvent.TIMER, onEnemiesTimer);
			//enemiesMoveTimer.stop();
			//enemiesMoveTimer.dispose();
			
			weaponController.removeEventListener(WeaponEvent.SHOOT, onShoot);
			weaponController.dispose();
			levelController.removeEventListener(LevelControllerEvent.ADD_ENEMY, onLevelControllerEvent);
			levelController.dispose();
		}
		
	}
}