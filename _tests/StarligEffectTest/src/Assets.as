package  {
	import flash.display.Bitmap;
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;
	//import flash.display3D.textures.Texture;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class Assets {
		
		[Embed(source = "../assets/pixel.png")]
		private static const Pixel:Class;
		
		[Embed(source = "../assets/square.png")]
		private static const Square:Class;
		
		[Embed(source = "../assets/square.xml", mimeType = "application/octet-stream")]
		private static const XMLClass:Class;
		
		private static var pixelTexture:Texture;
		
		public static function get pixel():Texture {
			if(!pixelTexture ) pixelTexture = Texture.fromBitmap(new Pixel as Bitmap);
			return pixelTexture;
		}
		
		public static function get square():MovieClip {
			var squareAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new Square as Bitmap), new XML(new XMLClass()));
			return new MovieClip(squareAtlas.getTextures("square_"), 60);
		}
		
	}

}