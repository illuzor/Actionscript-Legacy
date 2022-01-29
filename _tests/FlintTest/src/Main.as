package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.text.TextFormat;
	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.debug.Stats;
	import org.flintparticles.common.initializers.AlphaInit;
	import org.flintparticles.common.initializers.ApplyFilter;
	import org.flintparticles.common.initializers.ColorInit;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.twoD.actions.ApproachNeighbours;
	import org.flintparticles.twoD.actions.BoundingBox;
	import org.flintparticles.twoD.actions.Friction;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.ScaleAll;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	import org.flintparticles.twoD.zones.RectangleZone;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.displayObjects.Ring;
	
	/**
	 * ...
	 * @author illuzor //  illuzor@gmail.com
	 */
	
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var emitter:Emitter2D = new Emitter2D();
			emitter.counter = new Blast(500);
			
			emitter.addInitializer(new ColorInit(0xFF0000, 0x00FF00));
			emitter.addInitializer(new ApplyFilter(new BlurFilter(2, 2, 3)));
			emitter.addInitializer(new AlphaInit(0.9, 1));
			emitter.addInitializer(new ImageClass(Dot,[1.5]));
			//emitter.addInitializer(new ImageClass(Ring,[8]));
			
			emitter.addInitializer(new Position(new RectangleZone(0, 0, stage.stageWidth, stage.stageHeight)));
			
			emitter.addAction(new Move());
			emitter.addAction(new ApproachNeighbours(100, 90));
			emitter.addAction(new ScaleAll(2,10));
			//emitter.addAction(new Friction(100));
			
			var renderer:DisplayObjectRenderer= new DisplayObjectRenderer();
			renderer.addEmitter(emitter);
			addChild(renderer);
			
			emitter.start();
			
			var statistic:Stats = new Stats(0xFFFFFFFF, 0x00000000); //Создаем Stats (цвет текста, цвет фона)
			statistic.defaultTextFormat = new TextFormat("Arial", 13); //форматируем (не обязательно)
			addChild(statistic);  //добавляем на сцену (по умолчанию в верхний левый угол)
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void{
			
		}
		
	}
}