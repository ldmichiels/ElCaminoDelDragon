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
	//public var enemigos(default, null):Array<Enemigo>;
	//public var enemigosActivos(default, null):Array<Enemigo>;
	//private var dragon_enemigo:BadGreenDragon;
	private var enemigos:EnemyManager;

	// Fondos
	private var fondo1:FondoAnimado;
	private var fondo2:FondoAnimado;
	private var fondo3:FondoAnimado;

	//private var enemyTimer:Float;
	
	// Boton para ir al menu
	var backBtn:Boton;

	private var ancho:Int;
	private var alto:Int;
	private var alto_menu:Int;

	public function new () {
		super();
		
		fondo1 = new FondoAnimado('images/mountain.png',10);
		fondo2 = new FondoAnimado('images/tiny_mountains.png',70);
		fondo3 = new FondoAnimado('images/muralla.png',150);

		addChild(fondo1);
		addChild(fondo2);
		addChild(fondo3);

		hijos.push(fondo1);
		hijos.push(fondo2);
		hijos.push(fondo3);

		//enemigos = new Array<Enemigo>();
		//enemigosActivos = new Array<Enemigo>();
		
		//Cargo los enemigos
		//for(i in 0 ... MAX_ENEMIES) {
		//	enemigos.push(new Enemigo(this));
		//}

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
			//enemyTimer -= time;

			//if (enemyTimer < 0) {
				// Valor entre 2 y 5 segundos
			//	enemyTimer = Std.random(3) + 2;
				//if (enemigos.length > 0)
					//enemigos.pop().atack();
			//	EnemyManager.getInstance().turnOnEnemies('dragon_e');
			//}
			EnemyManager.getInstance().updateLogic(time);
			CollisionDetection.detectarColision3();
			} else {
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
/*
		tfield = new TextField();
		tfield.selectable = false;
		// Le restamos el 10% del ancho del boton para q el texto no quede en el borde
		tfield.width = w - (0.1 * w);
		tfield.height = h - (0.1 * h);

		tformat = new TextFormat('Arial', 30, 0xFFFFFF);
		tfield.setTextFormat(tformat);
		tfield.defaultTextFormat = tformat;

		this.addChild(tfield);*/
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
