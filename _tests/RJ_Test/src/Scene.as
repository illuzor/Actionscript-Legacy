package  {
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * контейнер для тайлов
	 */

	public class Scene extends Sprite {
		
		/** @private количество тайлов в ряду */
		private const TILES_ON_ROW:uint = 10;
		/** @private количество тайлов в колонке */
		private const TILES_ON_COLUMN:uint = 10;
		// в принципе, можно задать любые значения, не обязательно 10х10 (только маска(и некоторые другие параметры) сделана под 10х10)
		
		/** @private список всех тайлов */
		private var tiles:Vector.<Tile>;
		/** @private общее количество тайлов */
		private var _totalTiles:uint;
		
		public function Scene() {
			tiles = new Vector.<Tile>();
			makeTiles();
			sort();
			makeMask();
		}
		
		/** @private создание набора тайлов с добавлением в tiles */
		private function makeTiles():void {
			for (var i:int = 0; i < TILES_ON_COLUMN; i++) {
				for (var j:int = 0; j < TILES_ON_ROW; j++) {
					var tile:Tile = new Tile();
					tile.setPosinion(i, j);
					tiles.push(tile);
				}
			}
			_totalTiles = tiles.length;
		}
		
		/** @private сортировка тайлов для корректного отображения */
		private function sort():void {
			for (var i:int = TILES_ON_COLUMN-1; i >= 0; i--) {
				for (var j:int = 0; j <= TILES_ON_ROW-1; j++) {
					addChild(tiles[i * TILES_ON_ROW + j]);
				}
			}
		}
		
		/** @private создание маски для скрытия нунужных частей тайлов */
		private function makeMask():void {
			var maskShape:Shape = new Shape();
			addChild(maskShape);
			maskShape.y = 21;
			var maskGraphics:Graphics = maskShape.graphics;
			maskGraphics.beginFill(0xFFFFFF);
			maskGraphics.lineStyle(1, 0xFFFFFF)
			maskGraphics.lineTo(260, 200);
			maskGraphics.lineTo(520, 0);
			maskGraphics.lineTo(520, 500);
			maskGraphics.lineTo(260, 500);
			maskGraphics.lineTo(0, 500);
			maskGraphics.lineTo(0, 0);
			maskGraphics.endFill();
		}
		
		/** сброс высоты всех тайлов на ноль */
		public function reset():void {
			for (var i:int = 0; i < _totalTiles; i++) {
				tiles[i].yy = 0;
			}
		}
		
		/** применение высот к тайлам извне */
		public function set heights(value:Array):void {
			for (var i:int = 0; i < _totalTiles; i++) {
				tiles[i].yy = value[i];
			}
		}
		
		/** возврат набора высот тайлов */
		public function get heights():Array {
			var heights:Array = new Array();
			for (var i:int = 0; i < _totalTiles; i++) {
				heights.push(tiles[i].yy);
			}
			return heights;
		}
		
		/** общее количество тайлов */
		public function get totalTiles():uint {
			return _totalTiles;
		}
		
	}
}