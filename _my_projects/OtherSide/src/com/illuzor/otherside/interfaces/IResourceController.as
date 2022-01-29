package com.illuzor.otherside.interfaces {
	
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public interface IResourceController extends IEventDispatcher{
		function initialLoad():void;
		function loadResources(data:Object):void;
		function getAtlas(atlasName:String):TextureAtlas;
		function getTexture(atlasName:String, textureName:String):Texture;
		function getLevelConfig(zone:uint = 0, level:uint = 0):Object;
		function getCurve(id:String):Object;
		function getCurves(ids:Array):Object;
		function playMusic(musicName:String):void;
		function pauseMusic():void;
		function playSound(soundName:String, loops:uint = 0):SoundChannel;
		function get isMobile():Boolean;
		function get lang():Object;
	}
	
}