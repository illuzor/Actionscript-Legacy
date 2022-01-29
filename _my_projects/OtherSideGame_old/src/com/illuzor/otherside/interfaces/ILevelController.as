package com.illuzor.otherside.interfaces {

	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public interface ILevelController extends IEventDispatcher {
		
		function play():void;
		function pause():void;
		function dispose():void;
		
	}
	
}