package com.illuzor.bubbles.tools {
	
	import com.illuzor.bubbles.constants.ParticlesType;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.extensions.PDParticleSystem;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	/**
	 * Менеджер ресурсов. Загружает внешние ресурсы через AssetManager из starling
	 */
	
	public class ResourceManager {
		
		/** диспатчер для оповещения об окончании загрузки */
		public static var dispatcher:EventDispatcher;
		/** @private старлинговский менеджер ресурсов */
		private static var assetManager:AssetManager;
		/** @private список закэшированных текстур частиц */
		private static var particleTextures:Object = {};
		
		public static function load():void {
			dispatcher = new EventDispatcher();
			assetManager = new AssetManager();
			// добавляем в очередь атлас
			assetManager.enqueue("resources/atlas.png", "resources/atlas.xml");
			// добавляем в очередь основной конфиг и конфиги системы частиц
			assetManager.enqueue("resources/config.json", "resources/trail_particle.pex", "resources/exp_particle.pex", "resources/colision_particle.pex");
			// добавляем конфиг шрифта с заданием имени
			assetManager.enqueueWithName("resources/font.fnt", "font");
			assetManager.loadQueue(loadingProgress); // загружаем всё добавленное в очередь
		}
		
		/**
		 * @private функция для проверки загрузки
		 * 
		 * @param	aspect уровень загрузки от 0 до 1
		 */
		private static function loadingProgress(aspect:Number):void {
			if (aspect == 1) {
				particleTextures.starTexture = getAtlas().getTexture("star_particle"); // кэшируем текстуры частиц
				particleTextures.trailTexture = getAtlas().getTexture("trail_particle");
				dispatcher.dispatchEventWith(Event.COMPLETE);
				dispatcher = null;
			}
		}
		
		/**  @return атлас */
		public static function getAtlas():TextureAtlas {
			return assetManager.getTextureAtlas("atlas");
		}
		/** @return конфиг*/
		public static function getConfig():Object {
			return assetManager.getObject("config");
		}
		
		/**
		 * Функция для получения частиц по типу
		 * 
		 * @param	type тип частиц
		 * @return готовая система частиц
		 */
		public static function getParticles(type:uint):PDParticleSystem {
			var particles:PDParticleSystem;
			switch (type) {
				case ParticlesType.TRAIL_PARTICLES:
					particles = new PDParticleSystem(assetManager.getXml("trail_particle"), particleTextures.trailTexture);
				break;
				
				case ParticlesType.EXPLOSION_PARTICLES:
					particles = new PDParticleSystem(assetManager.getXml("exp_particle"), particleTextures.starTexture);
				break;
				
				case ParticlesType.COLLISION_PARTICLES:
					particles = new PDParticleSystem(assetManager.getXml("colision_particle"), particleTextures.starTexture);
				break;
			}
			return particles;
		}
	}
}