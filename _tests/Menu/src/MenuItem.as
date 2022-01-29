package  {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class MenuItem extends Sprite {
		
		private var title:String;
		private var container:Sprite = new Sprite();
		private var _expandable:Boolean;
		public var startY:uint;
		public var expanded:Boolean;
		
		public function MenuItem(title:String) {
			buttonMode = true;
			this.title = title;
			addTitle();
			
			container.x = -3;
			container.y = 29;
			addChild(container);
		}
		
		private function addTitle():void {
			var titleText:Sprite = new Sprite();
			titleText.graphics.beginFill(0x808040);
			titleText.graphics.drawRect(0, 0, MainMenu.MENU_WIDTH, 28);
			titleText.graphics.endFill();
			
			addChild(titleText);
			
			var titleTextField:TextField = new TextField();
			titleTextField.mouseEnabled = false;
			titleTextField.selectable = false;
			titleTextField.text = title;
			titleTextField.width = MainMenu.MENU_WIDTH;
			titleTextField.height = titleTextField.textHeight+4;
			titleTextField.y = (28 - titleTextField.height) / 2;
			titleTextField.autoSize = TextFieldAutoSize.CENTER;
			titleText.addChild(titleTextField);
		}
		
		public function addItem(item:MenuItem):void {
			if (!_expandable) _expandable = true;
			item.y = 29 * container.numChildren;
			container.addChild(item);
			
		}
		
		public function get expandable():Boolean {
			return _expandable;
		}
		
	}

}