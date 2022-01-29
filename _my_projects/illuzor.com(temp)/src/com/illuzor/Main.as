package com.illuzor
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextFormat;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.illuzor.graphics.*;

	/**
	 * ...
	 * @author iLLuzor  /// illuzor@illuzor.com
	 */
	
	
	 
	public class Main extends Sprite 
	{
		private var welcome:UnderConstruction;
		private var icons:Icons;
		private var sprite:Sprite;
		private var hello:Hello;
		
		private var info:Boolean = false;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addUnerConstruction();
		}
		
		private function addUnerConstruction():void {
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var corner:Corner = new Corner();
			addChild(corner);
			
			hello = new Hello();
			hello.x = (stage.stageWidth - hello.width) / 2;
			hello.y = 200;
			addChild(hello);
			hello.h.alpha = 0;
			hello.t.alpha = 0;
			hello.shine.alpha = 0;
			
			TweenLite.to(hello.h, 2, { alpha:1, onComplete:showUnder } );
			stage.addEventListener(Event.RESIZE, resizeFunc);
		}
		
		private function showUnder():void {
			TweenLite.to(hello.t, 2, { alpha:1, onComplete:showInfo } );
		}
		
		private function showInfo():void {
			icons = new Icons();
			icons.x = (stage.stageWidth - icons.width)/2 + 50;
			icons.y = (stage.stageHeight - icons.height) - 60;
			icons.alpha = 0;
			addChild(icons);
			info = true;
			TweenLite.to(icons, 2, {alpha:1, onComplete:showShine})
			
			icons.blog.num = 0;
			icons.twitter.num = 1;
			icons.facebook.num = 2;
			icons.gmail.num = 3;
			
			icons.blog.buttonMode = true;
			icons.twitter.buttonMode = true;
			icons.facebook.buttonMode = true;
			icons.gmail.buttonMode = true;
			
			icons.blog.addEventListener(MouseEvent.CLICK, buttonClicked);
			icons.twitter.addEventListener(MouseEvent.CLICK, buttonClicked);
			icons.facebook.addEventListener(MouseEvent.CLICK, buttonClicked);
			icons.gmail.addEventListener(MouseEvent.CLICK, buttonClicked);
			
		}
		
		private function showShine():void {
			TweenLite.to(hello.shine, 5, { alpha:1 } );
		}
		
		private function buttonClicked(e:MouseEvent):void {
			if (e.currentTarget.num == 0) {
				gotoSite("http://blog.illuzor.com/")
			} else if (e.currentTarget.num == 1) {
				gotoSite("http://twitter.com/iLLuzor")
			} else if (e.currentTarget.num == 2) {
				gotoSite("http://www.facebook.com/illuzor")
			} else if (e.currentTarget.num == 3) {
				gotoSite("mailto:illuzor@gmail.com")
			}
		}
		
		private function gotoSite(url:String):void {
			var targetURL:URLRequest = new URLRequest (url); 
			navigateToURL (targetURL);
		}
		
		private function resizeFunc(e:Event):void {
			hello.x = (stage.stageWidth - hello.width) / 2;
			if (info) {
				icons.x = (stage.stageWidth - icons.width)/2 + 50;
				icons.y = (stage.stageHeight - icons.height) - 60;
			}
			
		}
	}
}