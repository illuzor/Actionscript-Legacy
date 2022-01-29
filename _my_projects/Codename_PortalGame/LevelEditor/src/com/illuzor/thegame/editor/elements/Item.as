package com.illuzor.thegame.editor.elements {
	
	import com.illuzor.thegame.tools.Assets;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	public class Item extends Sprite {
		
		public var type:String;
		public var selected:Boolean;
		
		private var selectShape:Shape;
		
		public function Item(type:String) {
			this.buttonMode = true;
			this.type = type;
			addChild(new Bitmap(Assets.getImage(type)));
		}
		
		public function select():void {
			if (!selectShape) {
				selectShape = new Shape();
				selectShape.graphics.beginFill(0x0DB0FF, .5);
				selectShape.graphics.drawRect(0, 0, this.width, this.height);
				selectShape.graphics.endFill();
			}
			addChild(selectShape);
			selected = true;
		}
		
		public function unselect():void {
			removeChild(selectShape);
			selected = false;
		}
		
	}
}