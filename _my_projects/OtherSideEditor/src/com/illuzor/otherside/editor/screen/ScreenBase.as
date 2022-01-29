package com.illuzor.otherside.editor.screen {
	
	import com.illuzor.otherside.editor.tools.GlobalResizer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	public class ScreenBase extends Sprite {
		
		protected var stageWidth:uint;
		protected var stageHeight:uint;
		
		public function ScreenBase() {
			stageWidth = GlobalResizer.stageWidth;
			stageHeight = GlobalResizer.stageHeight;
		}
		
		public function dispose():void {
			throw new Error("ScreenBase.dispose() function must be overrided");
		}
		
	}
}