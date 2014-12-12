package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Assets;
import flash.media.Sound;
import engine.*;


class GameScene extends Scene {

	// Constantes
	private static var MAX_ENEMIES:Int = 15;

	// Personaje principal
	private var mercurio:Dragon;
	
	// Enemigos
	private var enemigos:EnemyManager;

	// Fondos
	private var fondo1:FondoAnimado;
	private var fondo2:FondoAnimado;
	private var fondo3:FondoAnimado;
	private var fondo4:FondoMultiple;

	private var fondo1V:FondoAnimado;
	private var fondo2V:FondoAnimado;
	private var fondo3V:FondoAnimado;
	private var fondo4V:FondoMultiple;
		
	// Boton para ir al menu
	var backBtn:Boton;

	private var ancho:Int;
	private var alto:Int;
	private var alto_menu:Int;
	private var puntaje:TextField;
	private var vida:BarraVida;
	private var cont:Int;
	private var vuelta:Int;
	private var estado:Bool;

	public function new () {
		super();
		
		this.crearFondos();
		this.crearFondosV();

		// Damos de alta el personaje principal
		mercurio = new Dragon(this);
		// Los coloco en Pantalla
		this.addChild(mercurio);
		hijos.push(mercurio);

		enemigos = EnemyManager.getInstance();

		this.crearEnemigos();

		alto_menu = 50;
		ancho = ElCaminoDelDragon.getInstance().stage.stageWidth;
		alto = ElCaminoDelDragon.getInstance().stage.stageHeight - alto_menu;
		createMenu();
		cont = 0;
		vuelta=1;
		estado = false;
	}

	override public function updateLogic(time:Float) {
		cont++;
		var cambio = false;
		
		if (cont % 1800 == 0) {
			vuelta++;
			cambio = true;
		}

		if (cambio) {
			if (vuelta % 2 != 0){
				fondo1V.visible = false;
				fondo2V.visible = false;
				fondo3V.visible = false;
				fondo4V.visible = false;

				fondo1.visible = true;
				fondo2.visible = true;
				fondo3.visible = true;
				fondo4.visible = true;

				estado = false;
			} else {
				fondo1.visible = false;
				fondo2.visible = false;
				fondo3.visible = false;
				fondo4.visible = false;

				fondo1V.visible = true;
				fondo2V.visible = true;
				fondo3V.visible = true;
				fondo4V.visible = true;

				estado = true;
			}
		}

		if (mercurio.isAlive()) {
			if(!estado) {
				super.updateLogic(time);
				EnemyManager.getInstance().updateLogic(time);
			} else {
				super.updateLogic(time * vuelta);
				EnemyManager.getInstance().updateLogic(time * vuelta);
			}
			//CollisionDetection.detectarColision3();
			puntaje.text = "Puntaje: " + Score.getInstance().getCurrentScore();
			
		} else {
			// Perdió, se vuelve al menu
			Score.getInstance().setMaxScore(Score.getInstance().getCurrentScore());
			ElCaminoDelDragon.getInstance().setScene('menu');
		}
	
	}

	private function createMenu() {
		this.graphics.beginFill(0x999999);
		this.graphics.drawRect(0, 0, this.ancho, this.alto_menu);
		this.graphics.endFill();

		backBtn = new Boton(0xcc3333, 100, 50, function(_){ElCaminoDelDragon.getInstance().setScene('menu');} );
		backBtn.setText("Menu");
		addChild(backBtn);

		puntaje = new TextField();
		puntaje.selectable = false;
		puntaje.width = 100;
		puntaje.height = this.alto_menu;
		puntaje.x = this.ancho - puntaje.width;
		puntaje.y = 0;

		var tf = new TextFormat('Arial', 15, 0xFFFFFF);
		puntaje.setTextFormat(tf);
		puntaje.defaultTextFormat = tf;
		this.addChild(puntaje);

		this.crearBarraVida();
	}

	private function crearBarraVida() {
		vida = new BarraVida(150, 15);
		this.addChild(vida);
		this.hijos.push(vida);
	}

	public function getAncho() {
		return this.ancho;
	}

	public function getAlto() {
		return this.alto;
	}

	public function getAltoMenu() {
		return this.alto_menu;
	}

	private function crearFondos() {
		/*
		fondo1 = new FondoAnimado('images/montania.png',10);
		fondo2 = new FondoAnimado('images/tiny_mountains.png',70);
		fondo3 = new FondoAnimado('images/muralla.png',150);
		*/
		fondo1 = new FondoAnimado('images/fondo1.png',10);
		fondo2 = new FondoAnimado('images/fondo2.png',30);
		fondo3 = new FondoAnimado('images/fondo3.png',80);
		//fondo4 = new FondoAnimado('images/fondo4.png',150);
		//fondo4 = new FondoAnimado('images/muralla_torre_simple.png',150);


		var arr_muralla = new Array<Bitmap>();
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_torre_simple.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/olitas.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_torre_invertida.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_simple.png')));
		arr_muralla.push(new Bitmap(Assets.getBitmapData('images/muralla_castillo_grande.png')));
		fondo4 = new FondoMultiple(arr_muralla, 150);

		addChild(fondo1);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		hijos.push(fondo1);
		hijos.push(fondo2);
		hijos.push(fondo3);
		hijos.push(fondo4);

		fondo1.visible = true;
		fondo2.visible = true;
		fondo3.visible = true;
		fondo4.visible = true;
	}

	private function crearFondosV() {
		fondo1V = new FondoAnimado('images/fondo1_veloz.png',10);
		fondo2V = new FondoAnimado('images/fondo2_veloz.png',30);
		fondo3V = new FondoAnimado('images/fondo3_veloz.png',80);
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
		fondo4V = new FondoMultiple(arr_muralla, 150);

		addChild(fondo1V);
		addChild(fondo2V);
		addChild(fondo3V);
		addChild(fondo4V);

		hijos.push(fondo1V);
		hijos.push(fondo2V);
		hijos.push(fondo3V);
		hijos.push(fondo4V);

		fondo1V.visible = false;
		fondo2V.visible = false;
		fondo3V.visible = false;
		fondo4V.visible = false;
	}

	private function crearEnemigos() {
		// Creamos algunos dragones enemigos
		var arr_e = new Array<Enemy>();
		for (i in 0...10) {
			arr_e.push(new BadGreenDragon(this, 0));
		}
		enemigos.addEnemies('dragon_e', arr_e);

		arr_e = [];
		for (i in 0...10) {
			arr_e.push(new BadGreenDragon(this, 0));
		}
		enemigos.addEnemies('dragon_e2', arr_e);
		
		// Creamos lanzas
		var arr_e = new Array<Enemy>();
		for (i in 0...3) {
			arr_e.push(new Lance(this, 0));
		}
		enemigos.addEnemies('lanza_e', arr_e);

		// Creamos fuego
		var arr_e = new Array<Enemy>();
		for (i in 0...3) {
			arr_e.push(new Fuego(this, 0));
		}
		enemigos.addEnemies('fuego_e', arr_e);
	}
}
