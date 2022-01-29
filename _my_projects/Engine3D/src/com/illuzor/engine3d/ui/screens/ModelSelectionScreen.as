package com.illuzor.engine3d.ui.screens {
	
	import com.illuzor.engine3d.events.MenuEvent;
	import com.illuzor.engine3d.Main;
	import com.illuzor.engine3d.ui.Button;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	[Event(name = "selectModel", type = "com.illuzor.engine3d.events.MenuEvent")]
	
	internal class ModelSelectionScreen extends Sprite {
		
		public var currentModel:uint;
		
		public function ModelSelectionScreen() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			/*var header:HeaderText = new HeaderText();
			header.tf.text = "select model";
			header.tf.width = header.tf.textWidth + 10;
			header.tf.x = (stage.stageWidth - header.width) / 2;
			header.y = 10;
			addChild(header);*/
			
			var buttonsContainer:Sprite = new Sprite();
			
			for (var i:int = 0; i < Main.data.models.length; i++) {
				var button:Button = new Button(Main.data.models[i].name, 100);
				button.y = i * 34;
				button.num = i;
				buttonsContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, buttonClick);
			}
			
			addChild(buttonsContainer);
			buttonsContainer.x = (stage.stageWidth - buttonsContainer.width) / 2;
			buttonsContainer.y = (stage.stageHeight - buttonsContainer.height) / 2;
		}
		
		private function buttonClick(e:MouseEvent):void {
			currentModel = e.currentTarget.num;
			dispatchEvent(new MenuEvent(MenuEvent.SELECT_MODEL));
		}
		
	}
}