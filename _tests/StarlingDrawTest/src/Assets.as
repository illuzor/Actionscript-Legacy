package   {
	
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets {
		
		[Embed(source="../assets/atlas.png")]
		private static const AtlasImgClass:Class
		
		[Embed(source="../assets/atlas.xml", mimeType = "application/octet-stream")]
		private static const AtlasXMLClass:Class;
		
		private static var _atlas:TextureAtlas;
		
		public static function get atlas():TextureAtlas {
			if (!_atlas) _atlas = new TextureAtlas(Texture.fromBitmap(new AtlasImgClass() as Bitmap), XML(new AtlasXMLClass()));
			return _atlas;
		}
		
	}
}