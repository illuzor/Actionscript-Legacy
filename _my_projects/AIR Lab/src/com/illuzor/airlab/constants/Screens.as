package com.illuzor.airlab.constants {
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	public class Screens {
		
		public static const ANE:String = "ANE";
		public static const AIR:String = "AIR";
		public static const STAGE_3D:String = "Stage 3D";
		
		public static var mainMenu:Array = [ { name:AIR }, { name:STAGE_3D }, { name:ANE } ];
		
		public static var airSections:Array = [ { name:ScreenType.STAGE_TEXT }, { name:ScreenType.CAMERA }, { name:ScreenType.CAMERA_UI } ];
		
		public static var stage3dSections:Array = [ { name:ScreenType.STARLING }, { name:ScreenType.ND2D }, { name:ScreenType.GENOME2D }, { name:ScreenType.STARLING },
		{ name:ScreenType.AWAY3D }, { name:ScreenType.ALTERNATIVA3D } ];
		
		public static const aneSections:Array = [ { name:ScreenType.OPEN_FILE }, { name:ScreenType.SEND_SMS }, { name:ScreenType.SEND_EMAIL }, { name:ScreenType.PHONE_CALL },
		{ name:ScreenType.SHARE_TEXT }, { name:ScreenType.SHARE_IMAGE } ];
		
		public static var currentScreenName:String;
		public static var currentSelectedScreen:Array;
		
	}

}