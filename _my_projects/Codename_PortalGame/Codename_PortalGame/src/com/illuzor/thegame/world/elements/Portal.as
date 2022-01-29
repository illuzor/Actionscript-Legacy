package com.illuzor.thegame.world.elements {
	
	import net.flashpunk.Entity;
	import com.illuzor.thegame.tools.Assets;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class Portal extends Entity {
		
		public function Portal() {
			type = "portal";
			graphic = new Image(Assets.getImage("PortalLeft"));
			setHitbox(12, 88);
		}
		
	}
}