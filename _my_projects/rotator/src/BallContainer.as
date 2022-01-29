package  
{
	import flash.display.Sprite;
	public class BallContainer extends Sprite
	{		
		public var xVector:Number = 0;	
		public var yVector:Number = 0;
		//public var jj:Number
		
		public function BallContainer(balls:Number, xVect:Number , yVect:Number, collor:Number)
		{
			//jj = 0
				for (var i:int = 0; i <= balls; i++) 
				{
					var ball:Ball = new Ball(10, collor);
					ball.x = xVector
					ball.y = yVector
					addChild(ball); 
					xVector += xVect; //(xVect + jj);
					yVector += yVect; //(yVect + jj);
					collor += 7;
					//jj += 3;
			}
		}
	}
}