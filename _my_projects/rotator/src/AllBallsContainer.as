package
{
	import flash.display.*;
	import flash.events.Event;
	public class AllBallsContainer extends Sprite
	{
		private var coolor:uint;
			
		public function AllBallsContainer(colorI:Number)
		{	
			coolor = colorI;

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			
			var a:BallContainer = new BallContainer(12, -15, -15, coolor);
			a.name = "LT";
			addChild(a);
			
			a = new BallContainer(12, 15, -15, coolor);
			addChild(a);
			
			a = new BallContainer(12, -15, 15, coolor);
			addChild(a);
			
			a = new BallContainer(12, 15, 15, coolor);
			addChild(a);
		}
		
		private function removeFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			
			while(numChildren)
			{
				removeChildAt(0);
			}
		}
	}
}