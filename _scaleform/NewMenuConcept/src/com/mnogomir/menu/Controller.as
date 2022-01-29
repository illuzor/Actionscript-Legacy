package com.mnogomir.menu {
	
	import com.mnogomir.menu.elements.ItemButton;
	import com.mnogomir.menu.elements.MenuObject;
	import com.mnogomir.menu.elements.Scrollbar;
	import scaleform.clik.core.UIComponent;
	import by.blooddy.crypto.serialization.JSON;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	public class Controller {
		
		private static var _menuObject:MenuObject;
		private static var depth:Array = [];
		private static var depthBaforeSearch:Array = [];
		private static var infoToShow:Boolean;
		private static var currentSelected:int = -1;
		
		private static var data:Object = { nodes:[], label:"Верхний уровень", data:null };
		private static var searchData:Object = { nodes:[], label:"Результат поиска", data:null };
		private static var currentData:Object;
		private static var searchResults:Vector.<ItemButton>;
		private static var searchShowed:Boolean;
		
		//private static var scrollbar:Scrollbar;
		//static private var currentSubMenuArray:Array;
		//private static var currentDataPiece:Object;
		
		//private static var searchResults:Vector.<ItemButton> = new Vector.<ItemButton>();

		public static function push(path:Array, lbl:String, dat:Number, info:String):void {
			//trace(info)
			if(lbl == ""){
				lbl = path[path.length - 1];
			}
			
			var currentObject:Object = data;
			
			for (var i:int = 0; i < path.length; i++) {
				
				var itemIndex:int = -1;
				var newObj:Object;
				
				if (currentObject.nodes == undefined) {
					currentObject.nodes = [];
					newObj = { label:path[i] };
					//newObj.info = info;
					currentObject.nodes.push( newObj );
				} else {
					itemIndex = getItemIndes(currentObject.nodes, path[i]);
					if (itemIndex == -1) {
						newObj = { label:path[i] };
						currentObject.nodes.push( newObj );
					} else {
						newObj = currentObject.nodes[itemIndex];
					}
				}
				currentObject = newObj;
			}

			if (currentObject.nodes == undefined) {
				currentObject.nodes = [];
			}
			currentObject.nodes.push( { label:lbl, dat:dat, info:info } );
			//data = tempMainObject;
			//trace(JSON.encode(data));
			currentData = data;
			showMenu();
		}
		
		private static function getItemIndes(nodes:Array, itemLabel:String):int {
			
			var finded:Boolean;
			
			for (var i:int = 0; i < nodes.length; i++) {
				if (nodes[i].label == itemLabel) {
					finded = true;
					break;
				}
			}
			if (finded) {
				return i;
			} else {
				return -1;
			}
		}
		
		public static function set menuObject(value:MenuObject):void {
			if(_menuObject == null) _menuObject = value;
		}
		
		private static function showMenu():void {
			//trace("searchShowed", searchShowed)
			_menuObject.hidePanel();
			while (_menuObject.itemsContainer.numChildren) {
				var tempMenuItem:ItemButton = _menuObject.itemsContainer.getChildAt(0) as ItemButton;
				tempMenuItem.removeEventListener(MouseEvent.CLICK, goToNexMenu);
				_menuObject.itemsContainer.removeChild(tempMenuItem);
			}
			
			var objectToShow:Object;
			if (!searchShowed) {
				objectToShow = data;
			} else {
				objectToShow = searchData;
			}
			
			var labelText:String = "";
			for (var j:int = 0; j < depth.length; j++) {
				objectToShow = objectToShow.nodes[depth[j]];
				labelText += objectToShow.label;
				if (j != depth.length - 1) labelText += " / ";
			}
			currentData = objectToShow;
			
			for (var i:int = 0; i < objectToShow.nodes.length; i++) {
				var menuItem:ItemButton = new ItemButton();
				menuItem.label = objectToShow.nodes[i].label;
				menuItem.buttonMode = true;
				menuItem.data = { num:i};
				
				if (objectToShow.nodes[i].nodes == undefined) {
					menuItem.data.type = "b";
					menuItem.data.info = objectToShow.nodes[i].info;
					trace(JSON.encode(objectToShow.nodes[i]))
					//trace(objectToShow.nodes[i].info)
					menuItem.folderIcon.visible = false;
				}
				else {
					menuItem.data.type = "m";
				}
				
				if(i != 0)menuItem.y = 23*i;
				_menuObject.itemsContainer.addChild(menuItem);
				_menuObject.height += 23;
				menuItem.addEventListener(MouseEvent.CLICK, goToNexMenu);
			}
			_menuObject.label = labelText;
			_menuObject.checkScrollbar(23*i);
		}
		
		static private function goToNexMenu(e:MouseEvent):void {
			//trace("info!!");
			currentSelected = -1;
			if (e.currentTarget.data.type == "m") {
				depth.push(e.currentTarget.data.num);
				showMenu();
			} else {
				//trace("current selected", infoToShow)
				//if (infoToShow)
				//trace(e.currentTarget.data.info);
				//trace("info!!");
				_menuObject.info = e.currentTarget.data.info
				_menuObject.showPanel();
				currentSelected = 1;
			}
			//trace("info!!");
		}
		
		static public function goBack():void {
			if (depth.length > 0) {
				depth.splice(depth.length - 1, 1);
				showMenu();
				_menuObject.hidePanel();
			} 
		}
		
		public static function search(searchingText:String):void {
			//trace("searchingText", searchingText)
			//searchResults = new Vector.<ItemButton>();
			resetSearch();
			searchData = { nodes:[], label:"Результат поиска", data:null };
			doSearch(currentData, searchingText);
			if (searchData.nodes.length > 0) {
				depthBaforeSearch = [];
				for (var i:int = 0; i < depth.length; i++) {
					depthBaforeSearch.push(depth[i]);
				}
				searchShowed = true;
				depth = [];
				showMenu();
				//showBySearch(searchResults);
			}
			
		}
		
		static public function resetSearch():void {
			if (searchShowed) {
				depth = [];
				
				for (var i:int = 0; i < depthBaforeSearch.length ; i++) {
					depth.push(depthBaforeSearch[i]);
				}
				depthBaforeSearch = [];
				searchShowed = false;
				showMenu();
			}
		}
		
		private static function doSearch(objToSearch:Object, searchingText:String):void {
			
			for (var i:int = 0; i < objToSearch.nodes.length; i++) {
				
				var toSearch:String = String(objToSearch.nodes[i].label);
				toSearch.toLowerCase();
				
				if (String(toSearch.toLowerCase()).search(searchingText.toLowerCase()) != -1) {
					searchData.nodes.push(objToSearch.nodes[i]);
					trace("finded", objToSearch.nodes[i].label)
				}
				if (objToSearch.nodes[i].nodes != undefined) doSearch(objToSearch.nodes[i], searchingText);
			}
		}
		
		/*private static function showBySearch(searchResults:Vector.<ItemButton>):void {
			
			while (_menuObject.itemsContainer.numChildren) {
				var tempMenuItem:ItemButton = _menuObject.itemsContainer.getChildAt(0) as ItemButton;
				tempMenuItem.removeEventListener(MouseEvent.CLICK, goToNexMenu);
				_menuObject.itemsContainer.removeChild(tempMenuItem);
			}
			
			for (var i:int = 0; i < searchData.nodes.length; i++) {
				
				var menuItem:ItemButton = searchResults[i];
				
				trace("menu item", menuItem.data.type)
				if (menuItem.data.type == "b") {
					menuItem.folderIcon.visible = false;
				}
				
				/*if (objectToShow.nodes[i].nodes == undefined) {
					menuItem.data.type = "b";
					menuItem.folderIcon.visible = false;
				}
				else {
					menuItem.data.type = "m";
				}*/
				
				//if (objectToShow.nodes[i].nodes == undefined) 
				//else menuItem.data.type = "m";
				
				/*if (i != 0) menuItem.y = 23 * i;
				_menuObject.itemsContainer.addChild(menuItem);
				menuItem.addEventListener(MouseEvent.CLICK, goToNexMenu);
			}
			_menuObject.label = "Результаты поиска";
		}*/
		
	/*	private function searchCurrentObject():Array {
			
		}*/
		
		/*static public function changeInfoView():void {
			infoToShow = !infoToShow;
			if (infoToShow && currentSelected > -1) {
				_menuObject.showPanel()
			} else if (!infoToShow){
				_menuObject.hidePanel();
			}
		}*/

	}
}