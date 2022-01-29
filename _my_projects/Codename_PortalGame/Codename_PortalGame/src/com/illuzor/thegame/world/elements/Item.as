package com.illuzor.thegame.world.elements {
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	//import com.illuzor.thegame.tools.AssetManager;
	import com.illuzor.thegame.tools.Assets;
	import com.illuzor.thegame.constants.WallType
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class Item extends Entity {
		
		public function Item(type:String, ix:uint, iy:uint, iw:uint, ih:uint) {
			this.graphic = new Image(Assets.getImage(type));
			this.x = ix;
			this.y = iy;
			setHitbox(iw, ih);
		}
		
	}
}