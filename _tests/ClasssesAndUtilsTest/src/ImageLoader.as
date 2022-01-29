package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author iLLuzor // http://illuzor.com // illuzor@gmail.com
	 */
	
	public class ImageLoader extends Sprite {
		private var tf:TextField;
		private var file:FileReference;
		
		public function ImageLoader() {
			
			tf = new TextField();
			tf.width = stage.stageWidth;
			addChild(tf);
			
			var button:Sprite = new Sprite();
			button.graphics.beginFill(0x00FF00);
			button.graphics.drawCircle(30, 50, 20);
			button.graphics.endFill();
			button.buttonMode = true;
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, showOpenFileDialog);
		}
		
		private function showOpenFileDialog(e:MouseEvent):void {
			var fileTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png");
			
			file = new FileReference();
			file.browse([fileTypes]);
			file.addEventListener(Event.SELECT, fileSelected);
			file.addEventListener(Event.CANCEL, fileOpenCanceled);
			file.addEventListener(IOErrorEvent.IO_ERROR, fileIOError);
		}

		private function fileIOError(e:IOErrorEvent):void {
			tf.text = "Ошибка загрузки файла";
		}
		
		private function fileOpenCanceled(e:Event):void {
			tf.text = "Загрузка файла отменена";
		}
		
		private function fileSelected(e:Event):void {
			tf.text = "Загрузка файла прошла успешно: " + file.name;
			file.load();
			file.addEventListener(Event.COMPLETE, loadSelectedComplete);
		}
		
		private function loadSelectedComplete(e:Event):void {
			var fileLoader:Loader = new Loader();
			fileLoader.loadBytes(file.data);
			fileLoader.x = 100;
			fileLoader.y = 100;
			addChild(fileLoader);
		}
		
	}
}