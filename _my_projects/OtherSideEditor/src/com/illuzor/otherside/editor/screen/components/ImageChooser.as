package com.illuzor.otherside.editor.screen.components {
	
	import com.bit101.components.PushButton;
	import com.illuzor.otherside.editor.events.ComponentEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ImageChooser extends ComponentBase {
		
		private var button:PushButton;
		private var imagesContainer:Sprite;
		
		public function ImageChooser(eventType:uint, w:uint, text:String, buttonText:String, images:Vector.<Sprite>) {
			super(eventType, w, text);
			button = new PushButton(this, label.width + 10, 0, buttonText);
			button.addEventListener(MouseEvent.CLICK, onButtonClick);
			
			imagesContainer = new Sprite();
			addChild(imagesContainer);
			
			var xCount:uint;
			var xWidth:uint;
			var yHeight:uint;
			for (var i:int = 0; i < images.length; i++) {
				var img:Sprite = images[i];
				img.x = xWidth;
				img.y = yHeight;
				imagesContainer.addChild(img);
				xCount++;
				xWidth += img.width + 4;
				if (xCount == 4) {
					xCount = 0;
					xWidth = 0;
					yHeight = imagesContainer.height + 4;
				}
				img.addEventListener(MouseEvent.CLICK, onImgClick);
			}
			
			imagesContainer.graphics.beginFill(0x0);
			imagesContainer.graphics.drawRect( -2, -2, imagesContainer.width + 4, imagesContainer.height + 4);
			imagesContainer.graphics.endFill();
			imagesContainer.y = -imagesContainer.height;
			imagesContainer.visible = false;
		}
		
		private function onImgClick(e:MouseEvent):void {
			imagesContainer.visible = false;
			dispatchEvent(new ComponentEvent(ComponentEvent.CHANGE_VALUE, { type:eventType, value:uint(e.currentTarget.name)} ));
		}
		
		private function onButtonClick(e:MouseEvent):void {
			imagesContainer.visible = !imagesContainer.visible;
		}
		
		override public function dispose():void {
			button.removeEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
	}
}