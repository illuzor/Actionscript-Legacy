package com.illuzor.lib.notifications {
	
	import com.illuzor.lib.graphics.FastRect;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class NotificationManger {
		/** @private Массив с объектами, содержащими информацию для окон. **/
		static private var notifArray:Vector.<Notification> = new Vector.<Notification>();
		/** @private Контейнер для отображения окон. **/
		static private var cont:Stage;
		
		static private var notifAdded:Boolean;
		
		/**
		 * Инициализация менеджера уведомлений.
		 * Задаёт контейнер для отображения уведомлений.
		 * Необходимо выполнить перед использованием.
		 * 
		 * @param	container контейнер, в который будут добавляться уведомления
		 */
		static public function init(container:Stage):void {
			cont = container;
		}
		
		static public function addSimple(text:String, forcedWidth:uint = 0, forcedHeight:uint = 0):void {
			var notification:Notification = new Notification(NotificationType.TEXT_WINDOW, text, forcedWidth, forcedHeight);
			notifArray.push(notification);
			if (!notifAdded) addToContainer();
		}
		
		
		static public function addWithButtons():void {
			
		}
		
		static private function addToContainer():void {
			cont.addChild(new FastRect(cont.stageWidth, cont.stageHeight, 0x0, .5));
			var currentNotif:DisplayObject = notifArray[0];
			cont.addChild(currentNotif);
			currentNotif.x = uint((cont.stageWidth - currentNotif.width) / 2);
			currentNotif.y = uint((cont.stageHeight - currentNotif.height) / 2);
			
			notifArray.shift();
			notifAdded = true;
		}
		
		static public function remove():void {
			while (cont.numChildren) cont.removeChildAt(0);
			notifAdded = false;
			if (notifArray.length > 0) addToContainer();
			
		}
		
		static public function removeAll():void {
			notifArray = new Vector.<Notification>();
			while (cont.numChildren) cont.removeChildAt(0);
		}
		
		
	}
}