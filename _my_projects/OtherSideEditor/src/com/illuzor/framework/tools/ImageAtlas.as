package com.illuzor.framework.tools {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class ImageAtlas {
		
		private var regions:Dictionary;
		private var imageData:BitmapData;
		
		public function ImageAtlas(imageData:BitmapData, xmlData:XML) {
			this.imageData = imageData;
			regions = new Dictionary();
			
			for each (var subTexture:XML in xmlData.SubTexture) {
				var name:String = subTexture.attribute("name");
				var x:Number = parseFloat(subTexture.attribute("x"));
				var y:Number = parseFloat(subTexture.attribute("y"));
				var width:Number = parseFloat(subTexture.attribute("width"));
				var height:Number = parseFloat(subTexture.attribute("height"));
				
				var region:Rectangle = new Rectangle(x, y, width, height);
				regions[name] = region;
			}
		}
		
		public function getBitmapData(name:String):BitmapData {
			var rect:Rectangle = regions[name];
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height);
			bitmapData.copyPixels(imageData, rect, new Point());
			return bitmapData;
		}
		
		public function getBitmap(name:String):Bitmap {
			var bitmap:Bitmap = new Bitmap(getBitmapData(name));
			bitmap.smoothing = true;
			return bitmap;
		}
		
		public function getSprite(name:String):Sprite {
			var sprite:Sprite = new Sprite();
			sprite.addChild(getBitmap(name));
			return sprite;
		}
		
		public function getShape(name:String):Shape {
			var bdata:BitmapData = getBitmapData(name);
			var shape:Shape = new Shape();
			shape.graphics.beginBitmapFill(bdata);
			shape.graphics.drawRect(0, 0, bdata.width, bdata.height);
			shape.graphics.endFill();
			return shape;
		}
	
	}
}