package com.illuzor.otherside {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	/**
	 * Preloader for android
	 * 
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Preloader extends Sprite {
		
		[Embed(source = "../../../../assets/graphics/loadingImage.png")]
		private const ImageClass:Class;
		private var game:DisplayObject;
		private var loadingImage:Bitmap;
		
		public function Preloader() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			setTimeout(makeImage, 120);
		}
		
		private function makeImage():void {
			loadingImage = new ImageClass() as Bitmap;
			addChild(loadingImage);
			
			loadingImage.x = (stage.stageWidth - loadingImage.width) >> 1;
			loadingImage.y = (stage.stageHeight - loadingImage.height) >> 1;
			
			var mainLoader:Loader = new Loader();
			mainLoader.load(new URLRequest("game.swf"));
			mainLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameLoaded);
		}
		
		private function onGameLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, onGameLoaded);
			game = e.target.content as DisplayObject;
			addChild(game);
			addEventListener(Event.COMPLETE, onGameReady);
		}
		
		private function onGameReady(e:Event):void {
			removeEventListener(Event.COMPLETE, onGameReady);
			e.stopImmediatePropagation();
			removeChild(loadingImage);
			loadingImage.bitmapData.dispose();
		}
		
	}
}