package com.illuzor.bubbles.tools {
	
	import com.illuzor.bubbles.graphics.Circle;
	import flash.utils.setTimeout;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	
	/**
	 * Класс для отложенной очистки эффектов и кругов.
	 * Нужен для очистки и удаления ненужных сущностей после их анимации.
	 * Удаление нужно не поментально, сначала нужно дождаться исчезновения круга и остановки систем частиц.
	 * Не создаёт лишних связей и его отлично вычищает GC.
	 */
	
	public class DelayedDestroyer {
		
		private var circle:Circle;
		private var container:DisplayObjectContainer;
		private var tf:TextField;
		private var particles:Array;
		
		 /**
		  * Конструктор деструктора =)
		  * 
		  * @param	container контейнер, в котором всё это дело лежит
		  * @param	circle круг для удаления
		  * @param	particles массив систем частиц для удаления
		  * @param	tf тестовое поле очков для удаления
		  * @param	delay время задержки в миллисекундах
		  */
		public function DelayedDestroyer(container:DisplayObjectContainer, circle:Circle, particles:Array, tf:TextField, delay:uint = 1000) {
			this.container = container;
			this.particles = particles;
			this.tf = tf;
			this.circle = circle;
			setTimeout(clear, delay);
		}
		
		/** @private удаляет объекты из дисплей листа и очишает их */
		private function clear():void {
			for (var i:int = 0; i < particles.length; i++) {
				container.removeChild(particles[i])
				Starling.juggler.remove(particles[i]);
				particles[i].dispose();
			}
			particles = null;
			
			container.removeChild(circle);
			circle.dispose();
			circle = null;
			
			container.removeChild(tf);
			tf.dispose();
			tf = null;
			
		}
		
	}
}