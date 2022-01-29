package com.illuzor.thegame.world {
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import com.illuzor.thegame.tools.Assets;
	import com.illuzor.thegame.GameMan;
	
	public class Hero extends Entity {
		
		private var power:Number = 0.2; //скорость
		private var jumpPower:Number = 6; //сила прыжка
		private var hFriction:Number = 0.95; //трение по горизонтали
		private var vFriction:Number = 0.99; //трение по вертикали
		private var xSpeed:Number = 0; //текушая скорость по горизонтали
		private var ySpeed:Number = 0; //текущая скорость по вертикали
		private var gravity:Number = 0.3; //сила гравитации

		public function Hero() {
			this.graphic = new Image(Assets.getImage("Hero"));
			setHitbox(19, 47); //определяем хитбокс, нужен для определения столкновений объектов.
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("jump", Key.UP, Key.W);
		}
		
		override public function update():void { //переопределяем функцию update(), вызывается каждый кадр
	
			var pressed:Boolean = false; //с помощью этой переменной будем узнавать когда нужные нам клавиши нажаты (сейчас false -не нажаты)
			if (Input.check("left")) { //если нажата клавиша "стрелка влево"
				xSpeed -= power; //уменьшаем текущую скорость по х
				pressed = true; //true - нажата
			}
			if (Input.check("right")) { //если нажата клавиша "стрелка вправо"
				xSpeed += power; //увеличиваем текущую скорость по х
				pressed = true; //true - нажата
			}
			if (collide("wall", x, y + 1)) { //если произошло столкновение с любым из объектов группы"wall"
				ySpeed = 0; //обнуляем вертикальную скорость
				if (Input.check("jump")) { //если нажата клавиша "стрелка вверх"
					ySpeed -= jumpPower; //уменьшаем вертикальную скорость(прыжок вверх)
				}
			}
			else {
				ySpeed += gravity; //иначе увеличиваем вертикальную скорость(прыжок вниз)
			}
			if (Math.abs(xSpeed) < 1 && !pressed) { //если горизонтальная скорость очень маленькая 
				xSpeed = 0; //обнуляем ее
			}
			
			xSpeed *= hFriction; //уменьшаем горизонтальную скорость из-за силы трения
			ySpeed *= vFriction; //уменьшаем вертикальную скорость из-за силы трения
			adjustXPosition(); //функции проверяющие столкновения по осям x и y
			adjustYPosition();
			
			/*if (collide("portal", x, y)) {
				GameMan.teleport();
				//ySpeed = 40
			}*/
		}
		
		private function adjustXPosition():void {
			for (var i:int = 0; i < Math.abs(xSpeed); i++) { //перебираем все значение от 0 до текущей скорости по оси x
				if (!collide("wall", x + FP.sign(xSpeed), y)) { //Если перемещяя игрока на 1 пиксель (FP.sign возвращает 1 если число положительное,) 
					x += FP.sign(xSpeed); //и -1 если отрицательное) игрок не сталкивается с стеной, то перемещаем игрока в этом направлении на 1 px
				}
				else { //иначе
					xSpeed = 0; //не перемещаем
					break;
				}
			}
		}
		
		private function adjustYPosition():void {
			for (var i:int = 0; i < Math.abs(ySpeed); i++) { //здесь все аналогично
				if (!collide("wall", x, y + FP.sign(ySpeed))) {
					y += FP.sign(ySpeed);
				}
				else {
					ySpeed = 0;
					break;
				}
			}
		}
		
	}
}