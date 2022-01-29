package com.illuzor.otherside.controllers.storage {
	
	import com.illuzor.otherside.interfaces.IStorageController;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public final class StorageManager {
		
		public static var controller:IStorageController;
		
		public static function init():void {
			if (!controller) {
				CONFIG::airmobile {
					controller = new StorageControllerMobile();
				}
				
				CONFIG::flashplayer {
					controller = new StorageControllerFlash();
				}
				controller.init();
			}
		}
		
	}
}