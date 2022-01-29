package com.illluzor.effect1 {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author illuzor
	 */
	
	[SWF(backgroundColor = "#000000", frameRate = "30", width = "1000", height = "1000")]
	
	[Live]
	public class Effect extends Sprite {
		
		[Embed(source="circle_image.png")]
		private const CircleClass:Class;
		private var circleBitmapData:BitmapData;

		private var objectsList:Vector.<Object> = new Vector.<Object>();
		private var shapesList:Vector.<Shape> = new Vector.<Shape>();
		private var graphicsContainer:Shape;
		private var objectCircle:Object;
		
		private const CIRCLES_NUM:uint = 25;

		public function Effect():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			updateAsset();
			createCircles();
			updateCircles();
			graphicsContainer = new Shape();
			addChild(graphicsContainer);
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
		}
		
		[LiveAssetUpdateListener]
		private function updateAsset():void {
			circleBitmapData = (new CircleClass() as Bitmap).bitmapData;
			updateCircles();
		}
		
		private function onMouseEvent(e:MouseEvent):void {
			if (e.type == MouseEvent.MOUSE_DOWN) {
				for (var i:int = 0; i < objectsList.length; i++) {
					if (mouseX > objectsList[i].x - 6 && mouseX < objectsList[i].x + 6 && mouseY > objectsList[i].y - 6 && mouseY < objectsList[i].y + 6) {
						objectCircle = objectsList[i];
						objectsList[i].dragged = true;
						break;
					}
				}
			} else {
				if (objectCircle) {
					objectCircle.dragged = false;
					objectCircle = null;
				}
			}
		}
		
		private function createCircles():void {
			for (var i:int = 0; i < CIRCLES_NUM; i++) {
				var circleObj:Object = {};
				circleObj.speed = Math.random() * 3.6 + .4;
				circleObj.directionX = Math.random() * randomBool();
				circleObj.directionY = Math.random() * randomBool();
				circleObj.dragged = false;
				circleObj.x = ((stage.stageWidth - 120) * Math.random()) + 60;
				circleObj.y = ((stage.stageHeight - 120) * Math.random()) + 60;
				objectsList.push(circleObj);
				var shape:Shape = new Shape();
				addChild(shape);
				shapesList.push(shape);
			}
		}
		
		private function addElements():void {
			graphicsContainer = new Shape();
			addChild(graphicsContainer);
		}
		
		private function onUpdate(e:Event):void {
			graphicsContainer.graphics.clear();
			drawCircles();
			drawLines();
		}
		
		[LiveCodeUpdateListener]
		private function updateCircles():void {
			for (var i:int = 0; i < shapesList.length; i++) {
				shapesList[i].graphics.clear();
				shapesList[i].graphics.lineStyle(1.5, 0xFF8000);
				shapesList[i].graphics.beginBitmapFill(circleBitmapData);
				shapesList[i].graphics.drawCircle(0, 0, 13);
				shapesList[i].graphics.endFill();
			}
		}
		
		[LiveCodeUpdateListener]
		private function drawLines():void {
			for (var i:int = 0; i < objectsList.length; i++) {
				for (var j:int = 0; j < objectsList.length; j++) {
					if (i != j) {
						var point1:Point = new Point(objectsList[i].x, objectsList[i].y);
						var point2:Point = new Point(objectsList[j].x, objectsList[j].y);
						var distance:uint = Point.distance(point1, point2);
						
						if (distance < 200 && j > i) {
							graphicsContainer.graphics.lineStyle(4*(1-0.005*distance)+.2, 0xFFFFFF, 1-0.005*distance);
							graphicsContainer.graphics.moveTo(point1.x, point1.y);
							graphicsContainer.graphics.lineTo(point2.x, point2.y);
						} else if (distance <= 26) {
							objectsList[i].directionX = -objectsList[i].directionX;
							objectsList[i].directionY = -objectsList[i].directionY;
							objectsList[j].directionX = -objectsList[j].directionX;
							objectsList[j].directionY = -objectsList[j].directionY;
						}
					}
				}
			}
		}
		
		[LiveCodeUpdateListener]
		private function drawCircles():void {

			for (var i:int = 0; i < objectsList.length ; i++) {
				
				if (objectsList[i].dragged) {
					objectCircle.x = mouseX;
					objectCircle.y = mouseY;
				} else {
					objectsList[i].x += objectsList[i].speed * objectsList[i].directionX*1.2;
					objectsList[i].y -= objectsList[i].speed * objectsList[i].directionY*1.2;
				}
				
				if (objectsList[i].x <= 4) {
					objectsList[i].x = 5;
					objectsList[i].directionX = -objectsList[i].directionX;
				} else if (objectsList[i].x >= stage.stageWidth - 4) {
					objectsList[i].x = stage.stageWidth - 5;
					objectsList[i].directionX = -objectsList[i].directionX;
				}
				
				if (objectsList[i].y <= 4) {
					objectsList[i].y = 5;
					objectsList[i].directionY = -objectsList[i].directionY;
				} else if (objectsList[i].y >= stage.stageHeight - 4) {
					objectsList[i].y = stage.stageHeight - 5;
					objectsList[i].directionY = -objectsList[i].directionY;
				}
				
				shapesList[i].x = objectsList[i].x;
				shapesList[i].y = objectsList[i].y;
				shapesList[i].rotation += objectsList[i].speed;
			}
		}

		private function randomBool():Number {
			if (Math.random() < 0.5) return -1;
			return 1;
		}
	
	}
}