package  {
	
	import com.illuzor.tools.ImageAtlas;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class AtlasTest extends Sprite {
		
		[Embed(source="../assets/atlas.png")]
		private const AtlasImgClass:Class
		
		[Embed(source="../assets/atlas.xml", mimeType = "application/octet-stream")]
		private const AtlasXMLClass:Class;
		
		public function AtlasTest() {
			var atlasBitmapData:BitmapData = (new AtlasImgClass() as Bitmap).bitmapData;
			var atlasXML:XML = XML(new AtlasXMLClass());
			
			var atlas:ImageAtlas = new ImageAtlas(atlasBitmapData, atlasXML);
			
			//var bitmapData:BitmapData = atlas.getBitmapData("camera_icon");
			//addChild(new Bitmap(bitmapData));
			addChild(atlas.getShape("camera_icon"));
			
			atlas.dispose();
			atlas = null;
		}
		
	}
}