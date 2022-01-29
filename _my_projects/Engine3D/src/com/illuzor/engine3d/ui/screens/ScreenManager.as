package com.illuzor.engine3d.ui.screens {
	
	import alternativa.engine3d.objects.Mesh;
	import com.illuzor.engine3d.events.MenuEvent;
	import com.illuzor.engine3d.Main;
	import com.illuzor.engine3d.net.DataLoader;
	import com.illuzor.engine3d.ui.Button;
	import com.illuzor.engine3d.ui.HeaderText;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	public class ScreenManager extends Sprite {
		
		private var mainMenu:MainMenu;
		private var modelSelectionScreen:ModelSelectionScreen;
		private var header:HeaderText;
		private var backButton:Button;
		private var aboutScreen:AboutScreen;
		
		private var currentScreen:String;
		private const MAIN_MENU_SCREEN:String = "main menu";
		private const ABOUT_SCREEN:String = "about";
		private const MODEL_SELECTION_SCREEN:String = "select model";
		private const MODEL_SCREEN:String = "model";
		
		
		public function ScreenManager() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			header = new HeaderText();
			header.y = 8;
			addChild(header);
			
			backButton = new Button("back", 60);
			backButton.x = backButton.y = 8;
			backButton.visible = false;
			addChild(backButton);
			backButton.addEventListener(MouseEvent.CLICK, backButtonHandler);
			
			showMainMenu();
		}

		private function showMainMenu():void {
			backButton.visible = false;
			currentScreen = MAIN_MENU_SCREEN;
			updateHeaderText(MAIN_MENU_SCREEN);
			mainMenu = new MainMenu();
			addChild(mainMenu);
			mainMenu.addEventListener(MenuEvent.SHOW_MODELS_MENU, showModelMenu);
			mainMenu.addEventListener(MenuEvent.SHOW_INFO, showInfo);
		}
		
		private function showModelMenu(e:MenuEvent):void {
			backButton.visible = true;
			mainMenu.removeEventListener(MenuEvent.SHOW_MODELS_MENU, showModelMenu);
			mainMenu.removeEventListener(MenuEvent.SHOW_INFO, showInfo);
			removeChild(mainMenu);
			currentScreen = MODEL_SELECTION_SCREEN;
			updateHeaderText(MODEL_SELECTION_SCREEN);
			modelSelectionScreen = new ModelSelectionScreen();
			addChild(modelSelectionScreen);
			modelSelectionScreen.addEventListener(MenuEvent.SELECT_MODEL, showModel);
		}
		
		private function showModel(e:MenuEvent):void {
			var currentModel:uint = modelSelectionScreen.currentModel;
			modelSelectionScreen.removeEventListener(MenuEvent.SELECT_MODEL, showModel);
			removeChild(modelSelectionScreen);
			backButton.visible = false;
			updateHeaderText("");
			loadModel(currentModel);
		}
		
		private function showInfo(e:MenuEvent):void {
			mainMenu.removeEventListener(MenuEvent.SHOW_MODELS_MENU, showModelMenu);
			mainMenu.removeEventListener(MenuEvent.SHOW_INFO, showInfo);
			removeChild(mainMenu);
			backButton.visible = true;
			currentScreen = ABOUT_SCREEN;
			updateHeaderText(ABOUT_SCREEN);
			aboutScreen = new AboutScreen();
			addChild(aboutScreen);
		}
		
		private function loadModel(numModel:uint):void {
			var obj:Object = Main.data.models[numModel];
			DataLoader.LoadModel(modelGetter, obj.type, obj.modelPath, obj.texturePath);
		}
		
		private function modelGetter(mesh:Mesh):void {
			var screen:Scene3d = new Scene3d(mesh);
			addChild(screen);
			currentScreen = MODEL_SCREEN;
			updateHeaderText(MODEL_SCREEN);
		}
		
		private function updateHeaderText(text:String):void {
			header.tf.text = text;
			header.tf.width = header.tf.textWidth + 10;
			header.tf.x = (stage.stageWidth - header.width) / 2;
		}
		
		private function backButtonHandler(e:MouseEvent):void {
			switch (currentScreen) {
				case ABOUT_SCREEN :
					removeChild(aboutScreen);
					showMainMenu();
				break;
				
				case MODEL_SELECTION_SCREEN :
					removeChild(modelSelectionScreen);
					modelSelectionScreen.removeEventListener(MenuEvent.SELECT_MODEL, showModel);

				break;
			}
		}
		
	}
}