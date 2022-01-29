package {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class MainMenu extends Sprite {
		
		private var headerText:String;
		private var itemsContainer:Sprite = new Sprite();
		
		public static const MENU_WIDTH:uint = 200;
		private const HEADER_HEIGHT:uint = 36;
		
		public function MainMenu(headerText:String) {
			this.headerText = headerText;
			addHeader();
			
			addChild(itemsContainer);
			itemsContainer.y = HEADER_HEIGHT + 1;
		}
		
		private function addHeader():void {
			var header:Sprite = new Sprite();
			header.graphics.beginFill(0xC0C0C0);
			header.graphics.drawRect(0, 0, MENU_WIDTH, HEADER_HEIGHT);
			header.graphics.endFill();
			
			addChild(header);
			
			var headerTextField:TextField = new TextField();
			headerTextField.selectable = false;
			headerTextField.text = headerText;
			headerTextField.width = MENU_WIDTH;
			headerTextField.height = headerTextField.textHeight + 4;
			headerTextField.y = (HEADER_HEIGHT - headerTextField.height) / 2;
			headerTextField.autoSize = TextFieldAutoSize.CENTER;
			header.addChild(headerTextField);
		}
		
		public function addItem(item:MenuItem):void {
			item.y = itemsContainer.numChildren * 29;
			item.startY = 29 * itemsContainer.numChildren;
			itemsContainer.addChild(item);
			
			item.addEventListener(MouseEvent.CLICK, onItemClick);
		}
		
		private function onItemClick(e:MouseEvent):void {
			var clickedItem:MenuItem = e.currentTarget as MenuItem;
			if (clickedItem.expandable) {
				if (!clickedItem.expanded) {
					openMenu(clickedItem);
					clickedItem.expanded = true;
				} else {
					closeMenu();
					clickedItem.expanded = false;
				}
				
			}
		}
		
		private function openMenu(clickedItem:MenuItem):void {
			for (var i:int = 0; i < itemsContainer.numChildren; i++) {
				var currentItem:MenuItem = itemsContainer.getChildAt(i) as MenuItem
				if (i > itemsContainer.getChildIndex(clickedItem)) {
					TweenLite.to(currentItem, .3, {y: currentItem.startY + clickedItem.height - 28});
				} else {
					TweenLite.to(currentItem, .3, {y: currentItem.startY});
				}
			}
		}
		
		private function closeMenu():void {
			for (var i:int = 0; i < itemsContainer.numChildren; i++) {
				var currentItem:MenuItem = itemsContainer.getChildAt(i) as MenuItem
				TweenLite.to(currentItem, .3, {y: currentItem.startY});
			}
		}
	
	}

}