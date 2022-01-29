package com.illuzor.circles.interfaces {
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public interface IController {
		function next():void;
		function getCorrectPoint(currentColor:uint):Point;
		function getColor():uint;
		function pause():void;
		function destroy():void;
	}
	
}