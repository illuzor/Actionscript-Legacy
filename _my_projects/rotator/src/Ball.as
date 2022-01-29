package 
{
import flash.display.*;
	public class  Ball extends Sprite
	{
		public var cont:Shape = new Shape();
		public function Ball (radius:Number, tcolor:Number)
		{
			cont.graphics.clear();
			cont.graphics.beginFill(tcolor);
			cont.graphics.drawCircle(0, 0, radius);
			addChild(cont);
		}
	}
}