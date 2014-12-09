package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import engine.*;

/**
 * @author ldmichiels
 */
class BadGreenDragon extends Enemy {
	/**
	 *	Este dragon solo se mueve de derecha a izquierda, y dispara bolas de fuego cada cierot tiempo.
	 */

	private var shootTimer:Float;

	public function new(scene:GameScene, max:Int) {
		super(scene, max);

		this.setImage(Assets.getBitmapData("images/dragon_enemigo.png"), 1, 4);
		//this.setExplodeImage(Assets.getBitmapData("images/sprite_dragon_enemigo_100x65.png"), 1, 4);
		this.setCredit(10);
		this.setDamage(8);
		/*
		this.shootTimer = 0;
		var fuego = new Weapon(this.scene, 10);
		fuego.setBulletImage(Assets.getBitmapData("images/fuego_chico.png"), 1, 4);
		fuego.setBulletExplodeImage(Assets.getBitmapData("images/fuego_explotando.png"), 1, 4);
		this.armas.setWeapon('fuego_e', fuego);
		*/
	}
/*
	override public function updateLogic(time:Float) {
		// para moverse...
		super.updateLogic(time);
		
		if (shootTimer > 0)
			this.shootTimer -= time;

		// para dispararar...
		if (this.shootTimer <= 0) {
			// @todo: Deberia ser configurable el tiempo en disparos
			shootTimer = 2.5;
			armas.getWeapon('fuego_e').shoot(this,'left');
		}
	}*/
/*
	override public function atack() {
		super.atack();
		this.x = 900;
		this.y = 50 + Std.random(500);
	}
*/
}