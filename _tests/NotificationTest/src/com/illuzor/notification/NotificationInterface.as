package com.illuzor.notification {
	
	import flash.external.ExtensionContext;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class NotificationInterface {
		private var context:ExtensionContext;
		
		public function NotificationInterface() {
			if(!context)context = ExtensionContext.createExtensionContext("com.illuzor.notification", null);
		}
		
		public function notify(message:String):void {
			context.call("notify", message);
		}
		
	}

}