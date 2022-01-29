package com.illuzor.bitmap {
	
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	
	internal class Panel extends Sprite {
		
		public var play:PushButton;
		public var pause:PushButton;
		public var randomize:PushButton;
		public var amplitude:NumericStepper;
		public var length:NumericStepper;
		public var speed:NumericStepper;
		public var singleColor:CheckBox;
		public var color1:ColorChooser;
		public var color2:ColorChooser;
		public var clearBackground:PushButton;
		public var autoclear:CheckBox;
		public var effects:ComboBox;
		
		public function Panel() {
			effects = new ComboBox(this, 0, 0, "EFFECT 1", ["EFFECT 1", "EFFECT 2", "EFFECT 3", "EFFECT 4"]);
			autoclear = new CheckBox(this, 0, this.height+8, "BACKGROUND AUTOCLEAR");
			autoclear.textColor = 0xFFFFFF;
			autoclear.selected = true;
			
			var col1Label:Label = new Label(this, 0, this.height + 8, "COLOR 1:");
			col1Label.textField.textColor = 0xFFFFFF;
			
			color1 = new ColorChooser(this, 0, this.height, 0xFFFFFF);
			color1.usePopup = true;
			
			var col2Label:Label = new Label(this, 0, color1.y + 22, "COLOR 2:");
			col2Label.textField.textColor = 0xFFFFFF;
			
			color2 = new ColorChooser(this, 0, color1.y+38, 0xFF00FF);
			color2.usePopup = true;
						
			singleColor = new CheckBox(this, 0, color2.y + 28, "SINGLE COLOR");
			singleColor.textColor = 0xFFFFFF;
			
			var speedLabel:Label = new Label(this, 0, singleColor.y + singleColor.height + 10, "SPEED:");
			speedLabel.width = 40;
			speedLabel.textField.textColor = 0xFFFFFF;
			
			speed = new NumericStepper(this, 44, singleColor.y + singleColor.height + 10);
			speed.width = 60;
			speed.minimum = 1;
			speed.maximum = 10;
			speed.editable = false;
			
			var lengthLabel:Label = new Label(this, 0, speed.y + speed.height + 10, "LENGTH:");
			lengthLabel.width = 40;
			lengthLabel.textField.textColor = 0xFFFFFF;
			
			length = new NumericStepper(this, 44, speed.y + speed.height + 10);
			length.width = 60;
			length.value = 30;
			length.minimum = 1;
			length.step = 10;
			length.maximum = 300;
			
			var amplLabel:Label = new Label(this, 0, length.y + length.height + 10, "AMPL.:");
			amplLabel.width = 40;
			amplLabel.textField.textColor = 0xFFFFFF;
			
			amplitude = new NumericStepper(this, 44, length.y + length.height + 10);
			amplitude.step = 10;
			amplitude.value = 100;
			amplitude.width = 60;
			amplitude.minimum = 0;
			amplitude.maximum = 250;
			
			clearBackground = new PushButton(this, 0, amplitude.y + amplitude.height + 10, "CLEAR BACKGROUND");
			clearBackground.width = 106
			
			randomize = new PushButton(this, 0, clearBackground.y + clearBackground.height + 10, "RANDOMIZE");
			randomize.width = 106
			
			play = new PushButton(this, 0, randomize.y + randomize.height + 10, "PLAY");
			play.width = 50;
			
			pause = new PushButton(this, 56, randomize.y + randomize.height + 10, "PAUSE");
			pause.width = 50;
		}
		
	}
}