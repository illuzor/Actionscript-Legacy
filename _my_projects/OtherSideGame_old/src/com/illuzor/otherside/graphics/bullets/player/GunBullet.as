package com.illuzor.otherside.graphics.bullets.player {
	
	import com.illuzor.otherside.constants.MovableType;
	import com.illuzor.otherside.tools.ResizeManager;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class GunBullet extends BulletBase {
		
		public function GunBullet(texture:Texture) {
			_type = MovableType.BULLET;
			_damage = 1;
			speed = -5;
			var img:Image = new Image(texture);
			img.scaleX = img.scaleY = ResizeManager.scale;
			addChild(img);
			img.pivotX = img.width >> 1;
			img.pivotY = img.height;
		}
		
	}
}