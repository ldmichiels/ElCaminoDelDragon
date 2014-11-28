package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;


class Enemigo extends GameElement{
	
	var volando:Animation;
	var scene:GameScene;
	var estado:Int;

	public function new (scene:GameScene) {
		super();
		// @todo: deberiamos sacar la imagen como un parametro
		volando = new Animation( Assets.getBitmapData("images/sprite_dragon_enemigo_100x65.png"), 1, 4);
		this.addChild(volando);
		this.hijos.push(volando);
		this.scene = scene;
		this.estado = 0;
		CollisionDetection.getInstance().subscribe(this);
	}

	public function die() {
		this.estado = 0;
		this.colision = 0;
		scene.enemigos.push(this);
		scene.enemigosActivos.remove(this);
		scene.hijos.remove(this);
		scene.removeChild(this);		
	}

	// Se crea el enemigo y empieza a avanzar desde fuera de la pantalla
	public function atack() {
		this.x = 1000;
		this.y = 50 + Std.random(500);
		this.estado = 1;
		scene.hijos.push(this);
		scene.addChild(this);
		scene.enemigosActivos.push(this);
	}
	
	override public function updateLogic(time:Float) {
		if (estado == 0)
			return;
		super.updateLogic(time);
		x -= time * 50;
		if (x < -100)
			die();

		if (this.colision > 0)
			this.die();

	}

}
