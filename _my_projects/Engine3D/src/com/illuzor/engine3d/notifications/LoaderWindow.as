package com.illuzor.engine3d.notifications  {
	
	import flash.display.Sprite;
	
	/**
	 * Окно прогресса загрузки.
	 * 
	 * @author illuzor  //  illuzor@gmail.com  //  illuzor.com
	 */
	
	internal class LoaderWindow extends Sprite {
		/**  Внешний вид окна */
		private var window:LoadingWindowDesign;
		/**
		 * Конструктор. Добавляет графику.
		 * 
		 * @param	text Текст для отображения в окне.
		 */
		public function LoaderWindow(text:String) {
			window = new LoadingWindowDesign();
			window.tf.text = text;
			window.line.scaleX = 0;
			window.tf.textColor = 0xFFFFFF;
			addChild(window);
		}
		/**
		 * Обновление полосы прогресса
		 * 
		 * @param	scale отношение загруженных байт к их общему количеству
		 */
		public function update(scale:Number):void {
			window.line.scaleX = scale;
		}
		
	}
}