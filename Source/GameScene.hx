package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
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

	public function new () {
		super();

		backBtn = new Boton(0xFFFFFF, 200, 50, function(_){ElCaminoDelDragon.getInstance().setScene('menu');} );
		
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
		this.addChild(enemigos);
		hijos.push(enemigos);
		//dragon_enemigo = new BadGreenDragon(this, 5);
		//EnemyManager.getInstance().createEnemies('dragon_e', dragon_enemigo, 2);
		//EnemyManager.getInstance().turnOnEnemies('dragon_e');
		//enemyTimer = 0;

		addChild(backBtn);
	}

	override public function updateLogic(time:Float) {
		
		super.updateLogic(time);
		//enemyTimer -= time;

		//if (enemyTimer < 0) {
			// Valor entre 2 y 5 segundos
		//	enemyTimer = Std.random(3) + 2;
			//if (enemigos.length > 0)
				//enemigos.pop().atack();
		//	EnemyManager.getInstance().turnOnEnemies('dragon_e');
		//}
		//EnemyManager.getInstance().updateLogic(time);
		CollisionDetection.detectarColision3();
	}

}
