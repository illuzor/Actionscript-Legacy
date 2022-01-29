package com.illuzor.otherside.controllers.resource {
	
	import com.illuzor.otherside.errors.ControllerError;
	import com.illuzor.otherside.events.ResourceControllerEvent;
	import com.illuzor.otherside.interfaces.IResourceController;
	import com.illuzor.otherside.Settings;
	import com.illuzor.otherside.utils.intArrayToVector;
	import flash.media.SoundChannel;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal final class ResourceControllerMobile extends EventDispatcher implements IResourceController {
		
		private var commonAssetManger:AssetManager;
		private var assetManager:AssetManager;
		
		private var _isMobile:Boolean = true;
		
		public function initialLoad():void {
			commonAssetManger = new AssetManager();
			commonAssetManger.enqueue("sounds/testSound.mp3");
			commonAssetManger.enqueueWithName("configs/langs/" + Settings.lang + ".lang", "lang");
			commonAssetManger.loadQueue(onInitialLoad);
		}
		
		private function onInitialLoad(aspect:Number):void {
			if (aspect >= 1) {
				dispatchEvent(new ResourceControllerEvent(ResourceControllerEvent.INITIAL_LOAD_COMPLETE));
			}
		}
		
		public function loadResources(data:Object):void {
			if (assetManager) clearAssetManager();
			else assetManager = new AssetManager();
			
			assetManager.enqueueWithName("configs/levels/zone1level1.osl", "level");
			
			for (var i:int = 0; i < data.atlasses.length; i++) {
				assetManager.enqueue("graphics/" + data.atlasses[i] + ".atf", "graphics/" + data.atlasses[i] + ".xml");
			}
			assetManager.enqueue("configs/fonts/press_font.fnt");
			
			assetManager.loadQueue(onResourcesLoad);
		}
		
		private function onResourcesLoad(aspect:Number):void {
			if (aspect >= 1) {
				dispatchEvent(new ResourceControllerEvent(ResourceControllerEvent.LOAD_COMPLETE));
			}
		}
		
		public function getAtlas(atlasName:String):TextureAtlas {
			var atlas:TextureAtlas = assetManager.getTextureAtlas(atlasName);
			if (!atlas) {
				throw new ControllerError("ResourceControllerMobile.getAtlas(). Incorrect atlas: " + atlasName);
				return null;
			}
			return atlas;
		}
		
		public function getTexture(atlasName:String, textureName:String):Texture {
			var atlas:TextureAtlas = assetManager.getTextureAtlas(atlasName);
			if (!atlas) {
				throw new ControllerError("ResourceControllerMobile.getTexture(). Incorrect atlas: " + atlasName + "texture: " + textureName);
			}
			return atlas.getTexture(textureName);
		}
		
		public function getLevelConfig(zone:uint = 0, level:uint = 0):Object {
			return assetManager.getObject("level");
		}
		
		public function getCurve(id:String):Object {
			var helper:SQLiteHelper = new SQLiteHelper();
			var curve:Object =  helper.selectCurve(id);
			curve.x = intArrayToVector(curve.x);
			curve.y = intArrayToVector(curve.y);
			helper.close();
			return curve;
		}
		
		public function getCurves(ids:Array):Object {
			var curves:Object = new Object();
			var helper:SQLiteHelper = new SQLiteHelper();
			for (var i:int = 0; i < ids.length; i++) {
				curves[ids[i]] = helper.selectCurve(ids[i]);
				curves[ids[i]].x = intArrayToVector(curves[ids[i]].x);
				curves[ids[i]].y = intArrayToVector(curves[ids[i]].y);
			}
			helper.close();
			return curves;
		}
		
		public function playMusic(musicName:String):void {
			
		}
		
		public function pauseMusic():void {
			
		}
		
		public function playSound(soundName:String, loops:uint = 0):SoundChannel {
			return null;
		}
		
		public function get lang():Object {
			return commonAssetManger.getObject("lang");
		}
		
		public function get isMobile():Boolean {
			return _isMobile;
		}
		
		private function clearAssetManager():void {
			assetManager.dispose();
			assetManager.purge();
		}
		
	}
}