package elements {
	
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * Класс кнопки меню.
	 * При наведении кнопка подсвечивается (если она не активирована)
	 * Кнопка имеет два состояния: активирована/деактивирована.
	 * Если кнопка активирована, то она не будет реагировать на наведение/отведение курсора
	 */
	
	public class MenuButton extends Sprite {
		/** активирована ли кнопка */
		public var activated:Boolean;
		/** номер кнопки */
		public var number:uint;
		/** тип страницы, которую открывает кнопка (галерея или статья) */
		public var pageType:String;
		/**
		 * Конструктор класса
		 * 
		 * @param	number номер кнопки
		 * @param	text текст, который отображается на кнопке
		 * @param	pageType тип страницы, которую открывает кнопка (галерея или статья). константа из PageType
		 */
		public function MenuButton(number:uint, text:String, pageType:String) {
			this.pageType = pageType;
			this.number = number;
			
			TweenPlugin.activate([GlowFilterPlugin]); // активируем твин плагин свечения
			
			var design:MenuButtonDesign = new MenuButtonDesign(); // создаём вид кнопки, который берётся из swc
			design.tf.text = text; // присваиваем текст
			design.tf.width = design.tf.textWidth + 18; // ширина текстовового поля
			design.background.width = design.invisibleButton.width = design.tf.width; // ширина подложки и прозрачной кнопки
			addChild(design);
			
			design.invisibleButton.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			design.invisibleButton.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		/**
		 * @private При наведении курсора подсвечиваем кнопку
		 * срабатывает только если кнопка не активирована. то есть переменная activated == false
		 * 
		 * @param	e событие наведение крусора
		 */
		private function onOver(e:MouseEvent):void {
			if(!activated) TweenLite.to(this, .5, {glowFilter:{color:0x91e600, alpha:1, blurX:20, blurY:20}});
		}
		/**
		 * @private При отведении курсора убираем свечение
		 * срабатывает только если кнопка не активирована. то есть переменная activated == false
		 * 
		 * @param	e событие отведения крусора
		 */
		private function onOut(e:MouseEvent):void {
			if(!activated) TweenLite.to(this, .5, {glowFilter:{color:0x91e600, alpha:0, blurX:40, blurY:40}});
		}
		/**
		 * активация кнопки. включаем свечение, задаём true переменной activated
		 */
		public function activate():void {
			activated = true;
			TweenLite.to(this, .5, {glowFilter:{color:0x91e600, alpha:1, blurX:20, blurY:20}});
		}
		/**
		 * деактивация кнопки. выключаем свечение, задаём false переменной activated
		 */
		public function deactivate():void {
			activated = true;
			TweenLite.to(this, .5, {glowFilter:{color:0x91e600, alpha:0, blurX:40, blurY:40}});
		}
		
	}
}