package com.illuzor.thegame.world {
	
	//import com.illuzor.thegame.world.elements.Floor;
	import com.illuzor.thegame.world.elements.Item;
	import com.illuzor.thegame.world.elements.Portal;
	import com.illuzor.thegame.world.elements.PortalV;
	import net.flashpunk.World;
	import com.illuzor.thegame.GameMan;
	
	/**
	 * ...
	 * @author illuzor // illuzor.com // illuzor@gmail.com
	 */
	public class Level extends World {
		
		public function Level(levelData:Object) {

			for (var i:int = 0; i < levelData.items.length; i++) {
				var item:Item = new Item(levelData.items[i].type, levelData.items[i].x,
				levelData.items[i].y, levelData.items[i].width, levelData.items[i].height);
				item.type = "wall";
				add(item);
			}
			
			var hero:Hero = new Hero();	
			hero.x = levelData.hero.x;
			hero.y = levelData.hero.y;
			add(hero);

		}
		
	}
}