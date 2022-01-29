package com.illuzor.otherside.controllers.resource {
	
	import com.illuzor.otherside.interfaces.IResourceController;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class ResourceManager {
		
		public static var controller:IResourceController
		
		public static function init():void {
			if (!controller) {
				if (!controller) {
					CONFIG::airmobile {
						controller = new ResourceControllerMobile();
					}
					
					CONFIG::flashplayer {
						controller = new ResourceControllerFlash();
					}
					//controller.init();
				}
			}
		}
	
	}
}