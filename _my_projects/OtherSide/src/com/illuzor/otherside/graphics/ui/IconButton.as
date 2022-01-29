package com.illuzor.otherside.graphics.ui {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class IconButton extends ButtonBase {
		
		private var buttonTexture:Texture;
		private var iconTexture:Texture;
		
		public function IconButton(buttonTexture:Texture, iconTexture:Texture) {
			this.iconTexture = iconTexture;
			this.buttonTexture = buttonTexture;
			super();
		}
		
		override protected function addGraphics():void {
			var image:Image = new Image(buttonTexture);
			addChild(image);
			touchRect = image.bounds;
			
			var icon:Image = new Image(iconTexture);
			addChild(icon);
			icon.touchable = false;
			
			icon.height = image.height * .55;
			icon.scaleX = icon.scaleY;
			icon.x = (image.width - icon.width) >> 1;
			icon.y = (image.height - icon.height) >> 1;
		}
		
	}
}