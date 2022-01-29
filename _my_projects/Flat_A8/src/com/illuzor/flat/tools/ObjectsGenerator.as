package com.illuzor.flat.tools {
	
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.primitives.Box;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class ObjectsGenerator {
		
		public static function generate(container:Object3D, settings:Array):void {
			for (var i:int = 0; i < settings.length; i++) {
				var box:Box = new Box(settings[i].w, settings[i].l, settings[i].h);
				box.setMaterialToAllSurfaces(settings[i].mat);
				box.x = settings[i].x;
				box.y = settings[i].y;
				box.z = settings[i].z;
				box.rotationX = settings[i].rotX;
				box.rotationY = settings[i].rotY;
				box.rotationZ = settings[i].rotZ;
				container.addChild(box);
			}
		}
		
	}
}