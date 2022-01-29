package com.illuzor.thegame.editor.panels {
	
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	public class EnterCodenamePanel extends Sprite {
		
		//private ;
		private var inputName:Text;
		
		public var okButton:PushButton;
		public var cancelButton:PushButton;
		
		public function EnterCodenamePanel() {
			
			inputName = new Text(this, 0, 22);
			inputName.width = 250;
			inputName.height = 20;
			
			inputName.textField.multiline = false;
			
			var enterName:Label = new Label(this, 60,0, "ENTER LEVEL CODENAME:");
			enterName.textField.selectable = false;
			
			okButton = new PushButton(this, 23, 52, "OK");
			cancelButton = new PushButton(this, 133, 52, "CANCEL");
		}
		
		public function showError(errorText:String):void {
			var errorTf:Label = new Label(this, 0, 82, errorText);
			errorTf.textField.textColor = 0xFF0000;
		}
		
		public function get enteredName():String {
			return inputName.text;
		}
		
		/*private function chechName(name:String):Boolean {
			
		}*/
		
	}

}