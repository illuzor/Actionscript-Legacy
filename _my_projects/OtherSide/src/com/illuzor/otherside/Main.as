package com.illuzor.otherside {
	
	import com.illuzor.otherside.controllers.AppController;
	import com.illuzor.otherside.controllers.ResizeManager;
	import com.illuzor.otherside.controllers.resource.ResourceManager;
	import com.illuzor.otherside.controllers.storage.StorageManager;
	import com.illuzor.otherside.debug.Logger;
	import com.illuzor.otherside.debug.log;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * 2048x1280
	 * 
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		private var starling:Starling;
		private var contextCreated:Boolean;
		private var rootCreated:Boolean;
		
		public function Main() {
			if (stage) onAdded();
			else addEventListener(flash.events.Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:flash.events.Event = null):void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAdded);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			CONFIG::ios {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
			CONFIG::flashplayer {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
			initParams();
			initStarling();	
		}
		
		private function initParams():void {
			CONFIG::debug {
				Logger.init(stage);
			}
			
			Settings.lang = Capabilities.language;
			ResizeManager.init(stage);
			ResizeManager.addResize(resize, false);
			StorageManager.init();
			ResourceManager.init();
		}
		
		private function initStarling():void {
			starling = new Starling(Game, stage, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			starling.antiAliasing = 4;
			starling.start();
			starling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingEvent);
			starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onStarlingEvent);
			starling.addEventListener(starling.events.Event.FATAL_ERROR, onStarlingEvent);
			
			CONFIG::debug {
				starling.showStats = true;
			}
		}
		
		private function onStarlingEvent(e:starling.events.Event):void {
			switch (e.type) {
				case starling.events.Event.CONTEXT3D_CREATE:
					log("[Main] Starling Context3D created");
					contextCreated = true;
				break;
				
				case starling.events.Event.ROOT_CREATED:
					log("[Main] Starling root created");
					rootCreated = true;
				break;
				
				case starling.events.Event.FATAL_ERROR:
					log("[Main] Starling Fatal Error");
				break;
			}
			if (contextCreated && rootCreated) {
				starling.removeEventListener(starling.events.Event.ROOT_CREATED, onStarlingEvent);
				starling.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, onStarlingEvent);
				starling.removeEventListener(starling.events.Event.FATAL_ERROR, onStarlingEvent);
				AppController.start();
			}
		}
		
		private function resize(stageWidth:uint, stageHeight:uint):void{
			starling.viewPort = new Rectangle(0, 0, stageWidth, stageHeight);
			starling.stage.stageWidth = stageWidth;
			starling.stage.stageHeight = stageHeight;
		}
		
	}
}