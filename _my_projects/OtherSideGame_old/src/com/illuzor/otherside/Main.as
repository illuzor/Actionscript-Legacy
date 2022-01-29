package com.illuzor.otherside {
	
	import com.illuzor.otherside.controllers.AppController;
	import com.illuzor.otherside.tools.ResizeManager;
	import com.illuzor.otherside.tools.StorageManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * 
	 * @author illuzor  //  illuzor.com
	 * 
	 */
	
	public class Main extends Sprite {
		
		private var starling:Starling;
		private var contextCreated:Boolean;
		private var rootCreated:Boolean;
		
		public function Main():void {
			addEventListener(flash.events.Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:flash.events.Event):void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAdded);
			initSettings();
			initControllers();
			initStarling();
		}
		
		[Inline]
		private final function initSettings():void {
			Settings.lang = "en";
		}
		
		[Inline]
		private final function initControllers():void {
			StorageManager.init();
			ResizeManager.init(stage);
			ResizeManager.addResize(resize, false);
		}
		
		[Inline]
		private final function initStarling():void {
			Starling.handleLostContext = true;
			starling = new Starling(Game, stage, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			starling.antiAliasing = 16;
			starling.start();
			starling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingEvent);
			starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onStarlingEvent);
			starling.addEventListener(starling.events.Event.FATAL_ERROR, onStarlingEvent);
			
			starling.showStats = true;
	}
		
		private function onStarlingEvent(e:starling.events.Event):void {
			switch (e.type) {
				case starling.events.Event.CONTEXT3D_CREATE:
					trace("[Main] Starling Context3D created");
					contextCreated = true;
				break;
				
				case starling.events.Event.ROOT_CREATED:
					trace("[Main] Starling root created");
					rootCreated = true;
				break;
				
				case starling.events.Event.FATAL_ERROR:
					trace("[Main] Starling Fatal Error");
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