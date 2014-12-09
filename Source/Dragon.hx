package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

class Dragon extends GameElement{
	
	var volando:Animation;
	//var fuego:Animation;
	var armas:WeaponManager;

	private var inmunidad:Float;
	private var vida:Int;
	private var sound:flash.media.Sound;
	public var scene:GameScene;
	public var shootTimer:Float;
	private var state:Bool;
	
	public function new (scene:GameScene) {
		
		super();
		this.scene = scene;
		//sound = Assets.getSound ("sound3");
		//CollisionDetection.getInstance().subscribe(this);

		volando = new Animation( Assets.getBitmapData("images/dragon.png"), 1, 4);
		this.addChild(volando);
		this.hijos.push(volando);
		this.x = 50;
		this.y = 300;

		armas = WeaponManager.getInstance();
		var fuego = new Weapon(this.scene, 5);
		fuego.setBulletImage(Assets.getBitmapData("images/fuego_chico.png"), 1, 4);
		fuego.setBulletExplodeImage(Assets.getBitmapData("images/fuego_explotando.png"), 1, 4);
		armas.setWeapon('fuego', fuego);

		inmunidad = 0;
		vida = 5;
		shootTimer = 0;
		state = true;
	}	
	
	override public function updateLogic(time:Float) {
		
		super.updateLogic(time);
		var ancho:Int = this.scene.getAncho();
		var alto:Int = this.scene.getAlto();
		var alto_menu:Int = this.scene.getAltoMenu();
		
		if (InputManager.getInstance().keyPressed('W') && y > alto_menu -1) {
			this.y--;
		} else {}
		
		if (InputManager.getInstance().keyPressed('S') && y + height < alto + alto_menu - 50 -1) {
			this.y++;
		} else {}

		if (InputManager.getInstance().keyPressed('A') && x > -1) {
			this.x--;
		} else {}
		
		if (InputManager.getInstance().keyPressed('D') && x + width < ancho -1) {
			this.x++;
		} else {}
       	
       	// El shooter timer lo deberia controlar el arma, Ella sabe cada cuanto se puede disparar
		if (shootTimer > 0) shootTimer -= time;

		if (shootTimer <= 0 && InputManager.getInstance().keyPressed('Q')) {
			shootTimer = 0.3;
			armas.getWeapon('fuego').shoot(this,'right');
		}

		//if (vida != 0) {
		if (Vida.getInstance().getVida() > 0) {
	       	if (inmunidad > 0) {
	       		inmunidad -= time;
	       		this.alpha = 0.5;
	       	} else {
	       		this.alpha = 1;
	       		if (CollisionDetection.detectarColision2(this)) {
	       			inmunidad = 3;
	       			Vida.getInstance().setVida(Vida.getInstance().getVida() - cast(CollisionDetection.getInstance().getLastCol(), Enemy).getDamage());
	       			//vida--;
	       			//sound.play();
	       		}
	       	}
	    } else {
       		this.visible = false;
       		this.state = false;
       	}
	}

	public function isAlive():Bool {
		return state;
	}

}
