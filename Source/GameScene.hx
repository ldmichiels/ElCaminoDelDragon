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
	//private var fondo4:FondoAnimado;
	private var fondo4:FondoMultiple;
	
	// Boton para ir al menu
	var backBtn:Boton;

	private var ancho:Int;
	private var alto:Int;
	private var alto_menu:Int;
	private var puntaje:TextField;
	private var vida:BarraVida;

	public function new () {
		super();
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

		// Damos de alta el personaje principal
		mercurio = new Dragon(this);
		// Los coloco en Pantalla
		this.addChild(mercurio);
		hijos.push(mercurio);

		enemigos = EnemyManager.getInstance();

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


		alto_menu = 50;
		ancho = ElCaminoDelDragon.getInstance().stage.stageWidth;
		alto = ElCaminoDelDragon.getInstance().stage.stageHeight - alto_menu;
		createMenu();
	}

	override public function updateLogic(time:Float) {
		if (mercurio.isAlive()) {
			super.updateLogic(time);
	
			EnemyManager.getInstance().updateLogic(time);
			//CollisionDetection.detectarColision3();
			puntaje.text = "Score: " + Score.getInstance().getCurrentScore();
			
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
}
