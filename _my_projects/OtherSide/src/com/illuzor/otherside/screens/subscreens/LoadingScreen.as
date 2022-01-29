package com.illuzor.otherside.screens.subscreens {
	
	import com.illuzor.otherside.controllers.ResizeManager;
	import com.illuzor.otherside.tools.AssetsMobile;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class LoadingScreen extends Sprite {
		
		public function LoadingScreen() {
			var loadingImage:Image = new Image(Texture.fromBitmap(AssetsMobile.loadingImage));
			addChild(loadingImage);
			loadingImage.x = (ResizeManager.stageWidth - loadingImage.width) >> 1;
			loadingImage.y = (ResizeManager.stageHeight - loadingImage.height) >> 1;
		}
		
	}
}