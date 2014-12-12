package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Assets;
import flash.media.Sound;
import engine.*;


class GameSceneVeloz extends GameScene {
	
	//private var vuelta:Int;
	
	public function new () {
		super();
		vuelta = 1;
	}

	override public function updateLogic(time:Float) {
		cont++;

		if (cont % 1800 != 0) {
			if (mercurio.isAlive()) {
				this.visible = true;
				super.updateLogic(time*vuelta);
		
				EnemyManager.getInstance().updateLogic(time*vuelta);
				//CollisionDetection.detectarColision3();
				puntaje.text = "Score: " + Score.getInstance().getCurrentScore();
				
			} else {
				// Perdió, se vuelve al menu
				Score.getInstance().setMaxScore(Score.getInstance().getCurrentScore());
				ElCaminoDelDragon.getInstance().setScene('menu');
			}
		} else {
			vuelta++;
			this.visible = false;
			ElCaminoDelDragon.getInstance().setScene('game');
		}
	}


	override private function crearFondos() {
		fondo1 = new FondoAnimado('images/fondo1_veloz.png',10);
		fondo2 = new FondoAnimado('images/fondo2_veloz.png',30);
		fondo3 = new FondoAnimado('images/fondo3_veloz.png',80);
		//fondo4 = new FondoAnimado('images/fondo4.png',150);
		//fondo4 = new FondoAnimado('images/muralla_torre_simple.png',150);


		var arr_muralla = new Array<Bitmap>();
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_torre_simple_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/olitas_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_torre_invertida_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple_veloz.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_castillo_grande_veloz.png')));
		fondo4 = new FondoMultiple(arr_muralla, 150);

		addChild(fondo1);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		hijos.push(fondo1);
		hijos.push(fondo2);
		hijos.push(fondo3);
		hijos.push(fondo4);
	}

	override private function crearEnemigos() {
		// Creamos algunos dragones enemigos
		var arr_e = new Array<Enemy>();
		for (i in 0...10) {
			arr_e.push(new BadGreenDragon(this, 0));
		}
		enemigos.addEnemies('dragon_e_veloz', arr_e);

	/*	arr_e = [];
		for (i in 0...10) {
			arr_e.push(new BadGreenDragon(this, 0));
		}
		enemigos.addEnemies('dragon_e2_veloz', arr_e);
	*/	
		// Creamos lanzas
		var arr_e = new Array<Enemy>();
		for (i in 0...3) {
			arr_e.push(new Lance(this, 0));
		}
		enemigos.addEnemies('lanza_e_veloz', arr_e);
	/*
		// Creamos fuego
		var arr_e = new Array<Enemy>();
		for (i in 0...3) {
			arr_e.push(new Fuego(this, 0));
		}
		enemigos.addEnemies('fuego_e_veloz', arr_e);
	*/
	}
}
