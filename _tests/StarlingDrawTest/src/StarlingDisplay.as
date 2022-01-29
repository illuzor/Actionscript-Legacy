package  {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class StarlingDisplay extends Sprite {
		
		public function StarlingDisplay() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			var atlas:TextureAtlas = Assets.atlas;
			
			var img1:Image = new Image(atlas.getTexture("img1"));
			img1.pivotX = 10;
			img1.pivotY = 10;
			addChild(img1);
			img1.scaleX = .5;
			
			var img2Container:Sprite = new Sprite();
			addChild(img2Container);
			
			var img2:Image = new Image(atlas.getTexture("img2"));
			img2Container.addChild(img2);
			img2Container.x = 200;
			img2Container.y = 300;
			
			var img3:Image = new Image(atlas.getTexture("img3"));
			//img3.rotation = 10
			img2Container.addChild(img3);
			//img3.x = 350;
			//img3.y = 350;
			
			
			//var imgBdata:BitmapData = StarlingTool.drawToBitmapData(img2Container);
			
			var img:Bitmap = StarlingTool.drawToBitmap(img1);
			Main.container.addChild(img);
		}
	
		
	}
}