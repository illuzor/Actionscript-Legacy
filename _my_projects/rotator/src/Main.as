package
{
	import flash.display.*;
	import flash.events.*;
	public class Main extends Sprite
	{
		public var mainRotator:AllBallsContainer;
		public var mainRotator1:AllBallsContainer;
		public var mainRotator2:AllBallsContainer;
		
		public function Main()
		{	
	
			
			mainRotator2 = new AllBallsContainer(0x89BABC);
			mainRotator2.x = 300;
			mainRotator2.y = 300;
			addChild(mainRotator2);
			
			mainRotator = new AllBallsContainer(0x39B623);
			mainRotator.x = 300;
			mainRotator.y = 300;
			addChild(mainRotator);
					
			mainRotator1 = new AllBallsContainer(0xD32C30);
			mainRotator1.x = 300;
			mainRotator1.y = 300;
			addChild(mainRotator1);
			
			
			
			addEventListener(Event.ENTER_FRAME, Rotator)
		}
		public function Rotator(e:Event):void 
		{
			mainRotator.rotation += 5;
			mainRotator1.rotation -= 3;
			mainRotator2.rotation += 0.09;

		}
	}
}