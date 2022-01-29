package  {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * Класс тайла
	 */
	
	public class Tile extends Sprite {
		
		/** @private контейнер для графики тайла. Именно он двигается вверх-вниз внутри основного спрайта */
		private var graphicsSprite:Sprite;
		
		public function Tile() {
			graphicsSprite = new Sprite();
			addChild(graphicsSprite);
			draw();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
		}
		
		/**
		 * @private startDrag() и stopDrag() спрайта с графикой
		 * 
		 * @param	e событие MouseEvent.MOUSE_DOWN
		 */
		private function onMouseEvent(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					// перетаскивание в пределах от -150 до 150
					graphicsSprite.startDrag(false, new Rectangle(0, -150, 0, 300));
					// если возможен mouseDown, значит экземпляр виден, следовательно stage точно существует
					// поэтому я не стал делать слушатель добавления на сцену
					stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
				break;
				case MouseEvent.MOUSE_UP:
					stopDrag();
					stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
				break;
			}
		}
		
		/** @private отрисовка графики тайла */
		private function draw():void {
			var spriteGraphics:Graphics = graphicsSprite.graphics; 
			
			// основной ромб
			spriteGraphics.lineStyle(1, 0x0);
			spriteGraphics.beginFill(0xC1C1C1);
			spriteGraphics.moveTo(0, 20);
			spriteGraphics.lineTo(26, 0);
			spriteGraphics.lineTo(52, 20);
			spriteGraphics.lineTo(26, 40);
			spriteGraphics.lineTo(0, 20);
			spriteGraphics.endFill();
			
			// левая грань
			spriteGraphics.beginFill(0xA4A1A1);
			spriteGraphics.lineStyle(1, 0x0);
			spriteGraphics.moveTo(0, 20);
			spriteGraphics.lineTo(0, 320);
			spriteGraphics.lineTo(26, 340);
			spriteGraphics.lineTo(26, 40);
			spriteGraphics.endFill();
			
			// правая грань
			spriteGraphics.beginFill(0x6A6A6A);
			spriteGraphics.lineStyle(1, 0x0);
			spriteGraphics.moveTo(26, 40);
			spriteGraphics.lineTo(26, 340);
			spriteGraphics.lineTo(52, 320);
			spriteGraphics.lineTo(52, 20);
			spriteGraphics.endFill();
		}
		
		/**
		 * установка точной позиции тайла
		 * 
		 * @param	xCount x позиция в сетке
		 * @param	yCount y позиция в сетке
		 */
		public function setPosinion(xCount:uint, yCount:uint):void {
			this.x = xCount * 26 + yCount * 26
			this.y = xCount * -20 + yCount * 20;
		}
		
		// .у координата graphicsSprite для установки/получения высоты 
		public function get yy():Number {
			return graphicsSprite.y;
		}
		
		public function set yy(value:Number):void {
			graphicsSprite.y = value;
		}
	}
}