package com.illuzor.notification {
	import flash.external.ExtensionContext;
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class NotificationExtention {
		
		private static var context:ExtensionContext;
		
		public static function init():void {
			if(!context) context = ExtensionContext.createExtensionContext("com.illuzor.notification.Notification", null);
		}
		
		public static function showToast(toastText:String):void {
			if (context) context.call("showToast", toastText);
		}
		
		public static function showNotification(title:String, text:String):void {
			if (context) context.call("showNotification", title, text);
		}
		
	}
}