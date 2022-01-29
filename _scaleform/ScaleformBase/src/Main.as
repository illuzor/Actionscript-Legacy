package {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import scaleform.gfx.Extensions;
	import com.greensock.TweenLite;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Main extends Sprite {
		
		/*[Embed(source = "../lib/ut3logo.png")] private var LogoBitmap:Class;
		private var sprite:MovieClip;*/
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var baseMovie:BaseMovie = new BaseMovie();
		
		private function init(e:Event = null):void {
		//public function Main():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			Extensions.enabled = true;
			
			baseMovie.x = baseMovie.y = 256;
			addChild(baseMovie);
			
			/*var button:ButtonSample = new ButtonSample();
			button.x = button.y = 100;
			button.label = "My test button";
			addChild(button)*/
			/*sprite = new MovieClip();
			sprite.x = sprite.y = 256;
			addChild(sprite);
			
			var bitmap:Bitmap = new LogoBitmap() as Bitmap;
			bitmap.smoothing = true;
			bitmap.x = bitmap.y = -256;
			
			sprite.addChild(bitmap);*/
			//sprite.rotationZ
			
			/*; 
			
			var button1:ButtonSample = new ButtonSample();
			button1.x = 100
			button1.y = 140;
			button1.label = "My test button 2";
			addChild(button1);*/
			//addEventListener(Event.ENTER_FRAME,)
			
			
			toSmall();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			baseMovie.rotationY += .3;
		}
		
		private function toSmall():void {
			TweenLite.to(baseMovie, 5, { scaleX:.3, scaleY:.3,onComplete:toBig } );
		}
		
		private function toBig():void {
			TweenLite.to(baseMovie, 5, { scaleX:1, scaleY:1,onComplete:toSmall } );
		}
		
	}
}