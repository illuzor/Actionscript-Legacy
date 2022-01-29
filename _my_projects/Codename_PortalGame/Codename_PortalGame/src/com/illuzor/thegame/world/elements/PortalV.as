package com.illuzor.thegame.world.elements {
	
	import net.flashpunk.Entity;
	import com.illuzor.thegame.tools.Assets;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class PortalV extends Entity {
		
		public function PortalV() {
			//type = "portal";
			graphic = new Image(Assets.getImage("PortalTop"));
			setHitbox(12, 88);
		}
		
	}
}