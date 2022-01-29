package elements {
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	
	/**
	 * Класс страницы статьи. Отображает полупрозрачную подложку и текст (из xml)
	 */
	
	public class ArticlePage extends Sprite {
		/** @private белая полупрозрачная подложка */
		private var background:Shape;
		/** @private текст для отображения */
		private var text:String;
		/** @private текстовый объект для текста */
		private var textObject:ArticleTextObject;
		/**
		 * Конструктор класса.
		 * Принимает строку с текстом, слушает событие добавления на сцену
		 * 
		 * @param	text текст для отображения
		 */
		public function ArticlePage(text:String) {
			this.text = text;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		/**
		 * @private добавлено на сцену, создаётся фон и текстовый объект
		 * 
		 * @param	e событие добавления на сцену
		 */
		private function addedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			background = new Shape(); // создаём и добавляем подложку. её графика ресуется через resize
			addChild(background);
			
			textObject = new ArticleTextObject(); // создаём текстовый объект, применяем текст, задаём координаты
			textObject.tf.text = text;
			textObject.x = 50;
			textObject.y = 120;
			addChild(textObject);
			
			this.alpha = 0; // делаем экземпляр полностью прозрачным для анимации. должно же быть хоть немного красоты ;)
			TweenLite.to(this, .8, { alpha:1 } ); // плавно увеличиваем альфу
			 
			resize(); // вызов resize нарисует графику подложки и задаст размеры текстОбджекта
			
			stage.addEventListener(Event.RESIZE, resize); // добавляем слушатель ресайза
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage); // добавляем слушатель удаления со сцены
		}
		/**
		 * Ресайз сцены. перерисовка подложки и задание размеров текстОбджекта. тут всё просто.
		 * 
		 * @param	e
		 */
		private function resize(e:Event = null):void {
			background.graphics.clear();
			background.graphics.beginFill(0xFFFFFF, .7);
			background.graphics.drawRect(40, 110, stage.stageWidth - 80, stage.stageHeight - 160)
			background.graphics.endFill();
			
			textObject.tf.width = stage.stageWidth - 100;
			textObject.tf.height = stage.stageHeight - 180;
		}
		
		private function removedFromStage(e:Event):void { // при удалении со сцены отключаем все слушатели, 
			//ибо, если не удалить, могут быть ошибки. да и для кармы хорошо
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			stage.removeEventListener(Event.RESIZE, resize);
		}
		
	}
}