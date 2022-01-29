package com.illuzor.otherside.graphics.game.weapons {
	
	import com.illuzor.otherside.interfaces.IMovable;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class Gun extends WeaponBase implements IMovable {
		
		public function Gun(texture:Texture) {
			super(texture);
			setParams(10,10);
		}
		
		public function move():void {
			this.y -= speed;
		}
		
	}
}