package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.constants.AsteroidSizeType;
	import com.illuzor.otherside.tools.ResizeManager;
	import com.illuzor.otherside.utils.intRandom;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class LevelControllerBase extends EventDispatcher {
		
		private var atlas:TextureAtlas;
		
		protected var levelConfig:Object;
		protected var gameAtlas:Object;
		protected var scale:Number;
		
		public function LevelControllerBase(levelConfig:Object, atlas:TextureAtlas) {
			this.atlas = atlas;
			this.levelConfig = levelConfig;
			scale = ResizeManager.scale;
			gameAtlas = { };
			cacheTextures();
		}
		
		[Inline]
		private final function cacheTextures():void {
			var texturesArray:Array = levelConfig.textures;
			for (var i:int = 0; i < texturesArray.length; i++) {
				var atlasName:String = texturesArray[i].atlas;
				var textureName:String = texturesArray[i].texture;
				var texture:Texture = atlas.getTexture(textureName);
				(this[atlasName] as Object)[textureName] = texture;
			}
		}
		
		protected function getAsteroidTexture(size:String):Texture {
			var textureName:String;
			switch (size) {
				case AsteroidSizeType.SMALL:
					textureName = String("asteroid_small_type" + intRandom(1, 3));
				break;
				case AsteroidSizeType.MEDIUM1:
					textureName = String("asteroid_medium1_type" + intRandom(1, 3));
				break;
				case AsteroidSizeType.MEDIUM2:
					textureName = String("asteroid_medium2_type" + intRandom(1, 3));
				break;
				case AsteroidSizeType.BIG:
					textureName = String("asteroid_big_type" + intRandom(1, 3));
				break;
			}
			return gameAtlas[textureName];
		}
		
		public function dispose():void {
			
		}
		
	}
}