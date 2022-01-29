package com.illuzor.leaptest.away3d.scene {
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.math.Plane3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.BitmapTexture;
	import com.greensock.TweenLite;
	import com.illuzor.leaptest.away3d.Assets;
	import com.illuzor.leaptest.away3d.events.SceneEvent;
	import com.illuzor.leaptest.away3d.Main;
	import com.leapmotion.leap.events.LeapEvent;
	import com.leapmotion.leap.Finger;
	import com.leapmotion.leap.Frame;
	import com.leapmotion.leap.Gesture;
	import com.leapmotion.leap.Hand;
	import com.leapmotion.leap.LeapMotion;
	import com.leapmotion.leap.SwipeGesture;
	import com.leapmotion.leap.Vector3;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	[Event(name = "swypeGuest", type = "com.illuzor.leaptest.away3d.events.SceneEvent")]
	
	public class LeapAwayScene extends ObjectContainer3D {
		
		private var spheres:Vector.<Mesh> = new Vector.<Mesh>();
		private var lastSwipe:int;
		private var currentImageIndex:int;
		private var leap:LeapMotion;
		private var objContainer:ObjectContainer3D;
		private var fingers:Vector.<Finger>;
		private var moveStarted:Boolean;
		private var deltaX:int;
		private var deltaY:int;
		private var deltaZ:int;
		public var cube1:Mesh;
		public var finger1:Mesh;
		public var finger2:Mesh;
		
		public function LeapAwayScene() {
			initObjects();
			initController();
		}
		
		private function initObjects():void {
			
			objContainer = new ObjectContainer3D();
			addChild(objContainer);
			
			var floorGeom:PlaneGeometry = new PlaneGeometry(800, 800);
			var floorMat:TextureMaterial = new TextureMaterial(new BitmapTexture(Assets.floorBitmap.bitmapData));
			var floor:Mesh = new Mesh(floorGeom, floorMat);
			objContainer.y = -300;
			objContainer.z = -300;
			objContainer. addChild(floor);
			
			cube1 = new Mesh(new CubeGeometry(), new TextureMaterial(new BitmapTexture(Assets.cube1.bitmapData)));
			cube1.y = 50;
			objContainer.addChild(cube1);
			
			var cube2:Mesh = new Mesh(new CubeGeometry(), new TextureMaterial(new BitmapTexture(Assets.cube2.bitmapData)));
			cube2.y = 50;
			cube2.x = - 200;
			cube2.z = -80;
			objContainer.addChild(cube2);
			
			var cube3:Mesh = new Mesh(new CubeGeometry(), new TextureMaterial(new BitmapTexture(Assets.cube3.bitmapData)));
			cube3.y = 50;
			cube3.x = 200;
			cube3.z = 80;
			objContainer.addChild(cube3);
			
			
			for (var i:int = 0; i < 5; i++) {
				var sphereMaterial:ColorMaterial = new ColorMaterial(0x00FF00);
				var sphereMesh:Mesh = new Mesh(new SphereGeometry(5), sphereMaterial);
				spheres.push(sphereMesh);
				addChild(sphereMesh);
				sphereMesh.visible = false;
			}
		}
		
		private function initController():void {
			leap = new LeapMotion();
			leap.controller.addEventListener(LeapEvent.LEAPMOTION_FRAME, update);
			leap.controller.addEventListener(LeapEvent.LEAPMOTION_CONNECTED, leapmotionConnectedHandler);
		
		}
		
		private function leapmotionConnectedHandler(e:LeapEvent):void {
			trace("connected")
			leap.controller.enableGesture(Gesture.TYPE_SWIPE);
		}
		
		public function startMoveCube():void {
			if (fingers.length && deltaX == 0 && deltaY == 0 && deltaZ == 0) {
				deltaX = spheres[0].x - cube1.x;
				deltaY = spheres[0].y - cube1.y;
				deltaZ = spheres[0].z - cube1.z;
				trace(deltaX, deltaY, deltaZ);
				Main.getStage().addEventListener(Event.ENTER_FRAME, onMoveCube);
			}
			
		}
		
		private function onMoveCube(e:Event):void {
			trace("move enter")
			if (fingers.length) {
				cube1.x = spheres[0].x - deltaX;
				cube1.y = spheres[0].y - deltaY;
				cube1.z = spheres[0].z - deltaZ;
			}
			
		}
		
		public function stopMoveCube():void {
			deltaX = 0;
			deltaY = 0;
			deltaZ = 0;
			Main.getStage().removeEventListener(Event.ENTER_FRAME, onMoveCube);
		}
		
		private function update(e:LeapEvent):void {
			var frame:Frame = e.frame;
			if (frame.hands.length > 0) {
				
				var hand:Hand = frame.hands[0];
				fingers = hand.fingers;
				var count:uint = fingers.length;
				if (count > 5)
					count = 5;
				
				for (var j:int = 0; j < 5; j++) {
					if (j < count) {
						if (!spheres[j].visible)
							spheres[j].visible = true;
					} else {
						if (spheres[j].visible)
							spheres[j].visible = false;
					}
				}
				
				if (fingers.length > 0) {
					if (fingers.length == 2) {
						finger1 = spheres[0];
						finger2 = spheres[1];
						dispatchEvent(new SceneEvent(SceneEvent.TWO_FINGERS, 0));
					}
					
					if (fingers.length == 1) {
						finger1 = spheres[0];
						dispatchEvent(new SceneEvent(SceneEvent.ONE_FINGER, 0));
					}
					if(fingers.length != 1 && fingers.length != 2)dispatchEvent(new SceneEvent(SceneEvent.OTHER_FINGER, 0));
					for (var i:int = 0; i < count; i++) {
						var startPos:Vector3 = e.frame.pointables[i].tipPosition;
						spheres[i].x = -startPos.x //*multiplier;
						spheres[i].y = startPos.y - 200;
						spheres[i].z = startPos.z // * multiplier;
					}
				}
			}
			
			var now:int = getTimer();
			if (now - lastSwipe > 800) {
				
				var gestures:Vector.<Gesture> = e.frame.gestures();
				for each (var gesture:Gesture in gestures) {
					if (gesture is SwipeGesture) {
						var swipe:SwipeGesture = gesture as SwipeGesture;
						if (swipe.speed > 1500 && Math.abs(swipe.direction.x) > Math.abs(swipe.direction.y)) {
							if (swipe.direction.x > 0) {
								currentImageIndex--;
								//dispatchEvent(new SceneEvent(SceneEvent.SWYPE, -1));
								TweenLite.to(objContainer, .3, {rotationY:objContainer.rotationY-90});
							} else {
								//dispatchEvent(new SceneEvent(SceneEvent.SWYPE, 1));
								currentImageIndex++;
								TweenLite.to(objContainer, .3, {rotationY:objContainer.rotationY+90});
							}
							lastSwipe = now;
							break;
						}
					}
				}
			}
		
		}
	
	}

}