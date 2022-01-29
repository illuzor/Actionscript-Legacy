package 
{
	import com.illuzor.firstflat.Flat3d;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author iLLuzor // illuzor.com // illuzor@gmail.com
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var theFlat:Flat3d;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			theFlat = new Flat3d(stage.stageWidth, stage.stageHeight, stage);
			addChild(theFlat);
		}
		
	}
	
}