package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

class Dragon extends GameElement{
	
	var volando:Animation;
	//var fuego:Animation;
	var armas:WeaponManager;

	private var inmunidad:Float;
	private var sound:flash.media.Sound;
	public var scene:GameScene;
	public var shootTimer:Float;
	
	public function new (scene:GameScene) {
		
		super();
		this.scene = scene;
		//sound = Assets.getSound ("sound3");
		//CollisionDetection.getInstance().subscribe(this);

		volando = new Animation( Assets.getBitmapData("images/sprite_dragon_100x65.png"), 1, 4);
		this.addChild(volando);
		this.hijos.push(volando);
		this.x = 50;
		this.y = 300;

		/*fuego = new Animation( Assets.getBitmapData("images/player_missile.png"), 7, 1);
		this.addChild(fuego);
		this.hijos.push(fuego);
				
		fuego.x = 54;
		fuego.y = 24;
		fuego.x = 54;
		fuego.y = -11;*/
		armas = WeaponManager.getInstance();
		var fuego = new Weapon(this.scene, 10);
		//fuego.setBulletImage(Assets.getBitmapData("images/player_missile.png"), 1, 6);
		fuego.setBulletImage(Assets.getBitmapData("images/fuego.png"), 1, 4);
		fuego.setBulletExplodeImage(Assets.getBitmapData("images/player_missile_explode.png"), 1, 8);
		armas.setWeapon('fuego', fuego);

		inmunidad = 0;
		shootTimer = 0;
	}	
	
	override public function updateLogic(time:Float) {
		
		super.updateLogic(time);
		
		if (InputManager.getInstance().keyPressed('W')) {
			this.y--;
		} else {}
		
		if (InputManager.getInstance().keyPressed('S')) {
			this.y++;
		} else {}

		if (InputManager.getInstance().keyPressed('A')) {
			this.x--;
		} else {}
		
		if (InputManager.getInstance().keyPressed('D')) {
			this.x++;
		} else {}
       	
       	// El shooter timer lo deberia controlar el arma, Ella sabe cada cuanto se puede disparar
		if (shootTimer > 0) shootTimer -= time;

		if (shootTimer <= 0 && InputManager.getInstance().keyPressed('Q')) {
			shootTimer = 0.3;
			armas.getWeapon('fuego').shoot(this,'right');
		}

       	if (inmunidad > 0) {
       		inmunidad -= time;
       		this.alpha = 0.5;
       	} else {
       		this.alpha = 1;
       		
       		for (enemigo in scene.enemigosActivos) {
		       	if (CollisionDetection.detectarColision(this, enemigo)) {
		       		inmunidad = 6;
		       		//sound.play();
		       	}	
       		}
       	}
	}

}
