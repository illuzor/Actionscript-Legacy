package com.illuzor.otherside.controllers {
	
	import com.illuzor.otherside.events.WeaponEvent;
	import com.illuzor.otherside.utils.MegaTimer;
	import flash.events.TimerEvent;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal final class WeaponTimer extends EventDispatcher {
		
		private var timer:MegaTimer;
		private var weaponType:uint;
		private var x:int;
		private var y:int;
		
		public function WeaponTimer(weaponType:uint, delayInSeconds:uint, x:int, y:int) {
			this.y = y;
			this.x = x;
			this.weaponType = weaponType;
			timer = new MegaTimer(delayInSeconds * 1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onTimer(e:TimerEvent):void {
			dispatchEvent(new WeaponEvent(WeaponEvent.SHOOT, weaponType, x, y));
		}
		
		public function play():void {
			timer.start();
		}
		
		public function pause():void {
			timer.pause();
		}
		
		public function dispose():void {
			timer.dispose();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer = null;
		}
		
	}
}