package com.mnogomir.menu.elements {
	
	//import com.scaleform.clikbrowser.controllers.ButtonBarDemoController;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import scaleform.clik.controls.Button;
	import scaleform.clik.controls.TextInput;
	import scaleform.clik.core.UIComponent;
	import flash.events.MouseEvent;
	import com.mnogomir.menu.Controller;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	public class MenuObject extends UIComponent {
		
		private var _itemsContainer:UIComponent;
		private var _label:NavLabel;
		//private var _viewButton:Button;
		private var panelMask:Shape;
		private var fullSize:Boolean = true;
		private var background:Shape;
		private var searchInput:SearchInput;
		private var searchButton:Button;
		private var backButon:Button;
		private var infoPanel:UIComponent;
		private var hideButton:Button;
		private var crossButton:Button;
		private var dragBar:UIComponent;
		private var infoText:InfoText;
		private var scrollBar:Scrollbar;
		private var scrollbar:Scrollbar;
		private var megaContainer:UIComponent;
		private var containerMask:Shape;
		
		public function MenuObject() {
			background = new Shape();
			background.graphics.beginFill(0xFFFFFF, .4);
			background.graphics.drawRect(0, 0, 330, 600);
			background.graphics.endFill();
			addChild(background);
			
			searchInput = new SearchInput();
			searchInput.width = 292;
			searchInput.height = 38;
			addChild(searchInput);
			
			searchButton = new SearchButton();
			searchButton.buttonMode = true;
			searchButton.x = 292;
			addChild(searchButton);
			searchButton.addEventListener(MouseEvent.CLICK, onSearch);
			searchInput.addEventListener(Event.CHANGE, onSearchChange);
			searchInput
			
			/*_viewButton = new BottomButton();
			_viewButton.buttonMode = true;
			_viewButton.label = "Просмотр";
			_viewButton.y = 562;
			_viewButton.width = 220;
			addChild(_viewButton);
			_viewButton.addEventListener(MouseEvent.CLICK, onViewClick);*/
			
			hideButton = new BottomButton();
			hideButton.buttonMode = true;
			hideButton.label = "Скрыть";
			//hideButton.x = 221;
			hideButton.y = 562;
			hideButton.width = 330;
			addChild(hideButton);
			hideButton.addEventListener(MouseEvent.CLICK, showOrHide);
			
			megaContainer = new UIComponent();
			megaContainer.y = 38 * 2;
			addChild(megaContainer);
			
			_itemsContainer = new UIComponent();
			//_itemsContainer.y = 38*2;
			megaContainer.addChild(_itemsContainer);
			
			containerMask = new Shape();
			//containerMask.y = 38*2;
			containerMask.graphics.beginFill(0x0);
			containerMask.graphics.drawRect(0, 0, 330, 524-38);
			containerMask.graphics.endFill();
			megaContainer.addChild(containerMask);
			containerMask.height = 524 - 38;
			_itemsContainer.mask = containerMask;
			
			backButon = new BackButton();
			backButon.buttonMode = true;
			backButon.y = 38;
			addChild(backButon);
			backButon.addEventListener(MouseEvent.CLICK, onGoBack);
			
			_label = new NavLabel();
			_label.text = "";
			_label.x = 38;
			_label.y = 46;
			addChild(_label);

			infoPanel = new UIComponent();
			infoPanel.x = 330;
			infoPanel.graphics.beginFill(0xFFFFFF, .4);
			infoPanel.graphics.drawRect(0, 0, 470, 600);
			infoPanel.graphics.endFill();
			addChild(infoPanel);
			
			panelMask = new Shape();
			panelMask.x = 330;
			panelMask.graphics.beginFill(0xFFFFFF, .4);
			panelMask.graphics.drawRect(0, 0, 470, 600);
			panelMask.graphics.endFill();
			panelMask.scaleX = 0;
			addChild(panelMask);
			infoPanel.mask = panelMask;
			
			crossButton = new CrossButton();
			crossButton.buttonMode = true;
			crossButton.x = 330 - 38 * 2;
			crossButton.visible = false;
			addChild(crossButton);
			crossButton.addEventListener(MouseEvent.CLICK, onCrossClick);
			
			dragBar = new UIComponent();
			dragBar.graphics.beginFill(0x808000, .2);
			dragBar.graphics.drawRect(0,0, 20, 600);
			dragBar.graphics.endFill();
			dragBar.x = -20;
			addChild(dragBar);
			dragBar.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			
			infoText = new InfoText();
			infoText.textComp.text = "";
			//infoText.x = 330;
			infoText.y = 450;
			infoPanel.addChild(infoText);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd)
		}
		
		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		private function onKeyPress(e:KeyboardEvent):void {
			if (e.keyCode == 13 && searchInput.text != "") {
				Controller.search(searchInput.text);
			}
		}
		
		private function onStartDrag(e:MouseEvent):void {
			this.startDrag(false, new Rectangle(20, 0, stage.stageWidth - 350, stage.stageHeight-600));
			stage.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}
		
		private function onStopDrag(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStopDrag);
			stopDrag();
		}
		
		private function onCrossClick(e:MouseEvent):void {
			crossButton.visible = false;
			searchInput.text = "";
			Controller.resetSearch();
		}
		
		private function onSearchChange(e:Event):void {
			if (searchInput.text.length > 0) {
				crossButton.visible = true;
			} else {
				crossButton.visible = false;
			}
		}
		
		private function onSearch(e:MouseEvent):void {
			if (searchInput.text.length > 0) {
				Controller.search(searchInput.text);
			} else {
				Controller.resetSearch();
			}
		}

		private function showOrHide(e:MouseEvent):void {
			fullSize = !fullSize;
			if (!fullSize) {
				background.alpha = .4;
				background.y += 38 * 2;
				background.height -= 38 * 2;
				//hideButton.x = 0;
				//hideButton.y = 562;
				//hideButton.width = 330;
				hideButton.label = "Показать";
			} else{
				background.alpha = 1;
				background.y -= 38 * 2;
				background.height += 38 * 2;
				//hideButton.x = 221;
				//hideButton.y = 562;
				//hideButton.width = 109;
				hideButton.label = "Скрыть";
			}
				searchInput.visible = fullSize;
				searchButton.visible = fullSize;
				backButon.visible = fullSize;
				_label.visible = fullSize;
				crossButton.visible = fullSize;
				//_viewButton.visible = fullSize;
				infoPanel.visible = fullSize;
				dragBar.visible = fullSize;
		}
		
		/*private function onViewClick(e:MouseEvent):void {
			//Controller.changeInfoView();
		}*/
		
		private function onGoBack(e:MouseEvent):void {
			Controller.goBack();
		}
		
		public function get itemsContainer():UIComponent {
			return _itemsContainer;
		}
		
		public function set label(value:String):void {
			_label.text = value;
		}
		
		/*public function get viewButton():Button {
			return _viewButton;
		}*/
		
		public function showPanel():void {
			TweenLite.to(panelMask, .5, { scaleX:1 } );
		}
		
		public function set info(value:String):void {
			if (scrollBar != null) {
				infoText.removeChild(scrollBar);
				scrollBar = null;
			}
			infoText.textComp.textField.text = value;
			infoText.textComp.textField.height = infoText.textComp.textField.textHeight + 6;
			trace(infoText.textComp.textField.height, infoText.mmask.height)
			if (infoText.textComp.textField.height > infoText.mmask.height) {	
				scrollBar = new Scrollbar(infoText.textComp.textField, infoText.mmask);
				scrollBar.x = 460;
				infoText.addChild(scrollBar);
			}
		}
		
		public function hidePanel():void {
			TweenLite.to(panelMask, .5, { scaleX:0 } );
		}
		
		public function checkScrollbar(h:uint):void {
			if (scrollbar != null) {
				megaContainer.removeChild(scrollbar);
				scrollbar = null;
			}
			//trace("!!!!!", _itemsContainer.height, containerMask.height)
			if (h > containerMask.height) {
				scrollbar = new Scrollbar(_itemsContainer, containerMask);
				scrollbar.x = 320;
				scrollbar.y = 0;
				scrollbar.scrollHeight = h;
				scrollbar.maskHeight = containerMask.height;
				megaContainer.addChild(scrollbar);
			}
			//scrollbar = new Scrollbar();
		}
		
	}
}