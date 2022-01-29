package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import com.illuzor.dialog.DialogManager;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com  //  illuzor@gmail.com
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			DialogManager.init(stage);
			DialogManager.addDialog("Do you want to do it?", [ { label:"YES", func:yesFunction }, { label:"NO", func:noFunction }, { label:"MAYBE" }, { label:"DON`T KNOW" }, { label:"OK" } ] );
			DialogManager.addDialog("Do you want to do it?", [ { label:"YES", func:yesFunction }, { label:"NO", func:noFunction }, { label:"DON`T KNOW" }, { label:"OK" } ] );
			DialogManager.addDialog("Do you want to do it?", [ { label:"YES", func:yesFunction }, { label:"NO", func:noFunction }, { label:"OK" } ] );
			//DialogManager.removeDialog();
			
			//DialogManager.addDialog("Hello");
			//
			//DialogManager.removeAllDialogs();
		}
		
		private function yesFunction():void{
			trace("YES pressed");
		}

		private function noFunction():void{
			trace("NO pressed");
		}
		
	}
	
}