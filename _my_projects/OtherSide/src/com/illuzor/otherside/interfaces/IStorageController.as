package com.illuzor.otherside.interfaces {
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public interface IStorageController {
		function init():void;
		
		function increaseRuns():void;
		
		function setBool(name:String, value:Boolean):void;
		function getBool(name:String):Boolean;
		
		function setInt(name:String, value:int):void;
		function getInt(name:String):int;
		
		function setObj(name:String, value:Object):void;
		function getObj(name:String):Object;
	}
	
}