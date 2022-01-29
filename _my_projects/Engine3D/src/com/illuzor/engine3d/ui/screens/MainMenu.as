package com.illuzor.engine3d.ui.screens {
	
	import com.illuzor.engine3d.ui.Button;
	import com.illuzor.engine3d.ui.HeaderText;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.illuzor.engine3d.events.MenuEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	[Event(name="showModelMenu", type="com.illuzor.engine3d.events.MenuEvent")]
	[Event(name = "showInfo", type = "com.illuzor.engine3d.events.MenuEvent")]
	
	internal class MainMenu extends Sprite {
		
		private var showModelsButon:Button;
		private var infoButton:Button;
		
		public function MainMenu() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			/*var header:HeaderText = new HeaderText();
			header.tf.text = "main menu";
			header.tf.width = header.tf.textWidth + 10;
			header.tf.x = (stage.stageWidth - header.width) / 2;
			header.y = 10;
			addChild(header);*/
			
			var buttonContainer:Sprite = new Sprite();
			
			showModelsButon = new Button("show models", 100);
			buttonContainer.addChild(showModelsButon);
			
			infoButton = new Button("about", 100);
			infoButton.y = 40;
			buttonContainer.addChild(infoButton);
			
			addChild(buttonContainer);
			buttonContainer.x = (stage.stageWidth - buttonContainer.width) / 2;
			buttonContainer.y = (stage.stageHeight - buttonContainer.height) / 2;
			
			showModelsButon.addEventListener(MouseEvent.CLICK, showModels);
			infoButton.addEventListener(MouseEvent.CLICK, showInfo);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}

		private function showInfo(e:MouseEvent):void {
			dispatchEvent(new MenuEvent(MenuEvent.SHOW_INFO));
		}
		
		private function showModels(e:MouseEvent):void {
			dispatchEvent(new MenuEvent(MenuEvent.SHOW_MODELS_MENU));
		}
		
		private function removed(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			showModelsButon.removeEventListener(MouseEvent.CLICK, showModels);
			infoButton.removeEventListener(MouseEvent.CLICK, showInfo);
		}
		
	}
}