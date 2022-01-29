package com.illuzor.flat {
	
	import alternativa.engine3d.materials.FillMaterial;
	import flash.display.Bitmap;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.materials.TextureMaterial
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Settings {
		
		public static const PLANE_TYPE:String = "plane";
		public static const BOX_TYPE:String = "box";
		
		//[Embed(source="../../../../lib/floorTexture.png")] private static var FloorTexture:Class
		
		public static var elements:Array = new Array(
		{name:"floor", x: -320, y:60, z:0, rotX:0 , rotY:0, rotZ:0, w:944, l:744,  h:0, mat:new FillMaterial(0x0FFFF0) },
		//{name:"floor", x: -320, y:60, z:0, rotX:0 , rotY:0, rotZ:0, w:944, l:744,  h:0, mat:new TextureMaterial(new BitmapTextureResource((new FloorTexture() as Bitmap).bitmapData)) },
		//{name:"floor", x: -1024, y:60, z:0, rotX:0 , rotY:0, rotZ:0, w:2048, l:2048,  h:0, mat:new TextureMaterial(new BitmapTextureResource((new FloorTexture() as Bitmap).bitmapData)) },
		{name:"livingWallRight", x:150, y:60, z:120, rotX:0 , rotY:1.5708, rotZ:0, w:240, l:740,  h:0, mat:new FillMaterial(0xFF0000)} ,
		{name:"livingWallBottom", x:-60, y:-310, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:420, l:240,  h:0, mat:new FillMaterial(0x00FF00)},
		{name:"livingTopRight", x:112, y:320, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:76, l:240,  h:20, mat:new FillMaterial(0x0000FF)},
		{name:"livingTopLeft", x:-112, y:320, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:76, l:240,  h:20, mat:new FillMaterial(0x0000FF)},
		{name:"livingBottomBottom", x:-160, y:-294, z:120, rotX:1.5708 , rotY:0, rotZ:1.5708, w:32, l:240,  h:20, mat:new FillMaterial(0x0000FF)},
		{name:"livingWallLeft", x:-160, y:108, z:120, rotX:0 , rotY:0, rotZ:0, w:20, l:644,  h:240, mat:new FillMaterial(0x669900)},
		{name:"bottomLeft", x:-568, y:-310, z:120, rotX:1.5708 , rotY:1.5708, rotZ:0, w:240, l:444,  h:0, mat:new FillMaterial(0xFFFF00)},
		{name:"leftWall", x:-790, y:0, z:120, rotX:0 , rotY:1.5708, rotZ:0, w:240, l:620,  h:0, mat:new FillMaterial(0xFF0000)},
		{name:"bedroomTop", x:-320, y:310, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:300, l:240,  h:0, mat:new FillMaterial(0xD88A03)},
		{name:"kitchenTop", x:-640, y:310, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:300, l:240,  h:0, mat:new FillMaterial(0xD88A03)},
		{name:"bedroomLeftWall", x:-480, y:65, z:120, rotX:0 , rotY:0, rotZ:0, w:20, l:490,  h:240, mat:new FillMaterial(0x669900)},
		{name:"bedroomLeftBottom", x:-454, y:-170, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:32, l:240,  h:20, mat:new FillMaterial(0x0000FF)},
		{name:"bedroomRightBottom", x:-272, y:-170, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:204, l:240,  h:20, mat:new FillMaterial(0x0000FF)},
		{name:"bathroomRightBottom", x:-600, y:-283, z:120, rotX:1.5708 , rotY:0, rotZ:1.5708, w:53, l:240,  h:20, mat:new FillMaterial(0xF000FF)},
		{name:"bathroomRightTop", x:-600, y:-164, z:120, rotX:1.5708 , rotY:0, rotZ:1.5708, w:53, l:240,  h:20, mat:new FillMaterial(0xF000FF)},
		{name:"bathroomTop", x:-700, y:-147, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:180, l:240,  h:20, mat:new FillMaterial(0xF0F0FF)},
		{name:"kitchenBottomLeft", x:-679, y:-67, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:222, l:240,  h:20, mat:new FillMaterial(0xF0F0FF)},
		{name:"windowBalcony", x:0, y:430, z:120, rotX:1.5708 , rotY:0, rotZ:0, w:300, l:240,  h:0, mat:new FillMaterial(0xD88A03)}
		);
		
		
		
	}
}