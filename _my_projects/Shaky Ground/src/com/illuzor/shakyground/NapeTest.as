package com.illuzor.shakyground {
	
	import flash.Boot;
	import flash.display.Sprite;
	import flash.events.Event;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.util.Debug;
	import nape.util.ShapeDebug;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class NapeTest extends Sprite {
		
		private var space:Space;
		private var debug:Debug;
		//private var debug:Debug;
		
		public function NapeTest() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//
			
			space = new Space(new Vec2(0, 0));
			
			var body:Body = new Body(BodyType.DYNAMIC, new Vec2(stage.stageWidth / 2, stage.stageHeight / 2));
			body.shapes.add(new Circle(50, new Vec2(0, 0), Material.wood()));
			body.align();
			body.space = space;
			
			/*var body2:Body = new Body(BodyType.DYNAMIC, new Vec2(550, 300));
			body2.shapes.add(new Circle(50, new Vec2(0, 0), Material.steel()));
			body2.align();
			body2.space = space;*/
			
			debug = new ShapeDebug(stage.stageWidth, stage.stageHeight, 0xFFFFFF);
			addChild(debug.display);
			
			addEventListener(Event.ENTER_FRAME, update);
			//stage.addEventListener)addEventListener()
		}
		
		private function update(e:Event):void {
			//trace(space.step)
			if (stage.mouseX < stage.stageWidth / 2) {
				
			} else if (stage.mouseX < stage.stageWidth / 2) {
				
			}
			
			if (stage.mouseY < stage.stageHeight / 2) {
				
			} else if (stage.mouseY < stage.stageHeight / 2) {
				
			}
			
			space.step(1 / 60);
			debug.clear();
			debug.draw(space);
			
		}
		
	}

}