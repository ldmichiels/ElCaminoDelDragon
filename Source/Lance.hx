package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import engine.*;

/**
 * @author ldmichiels
 */
class Lance extends Enemy {


	public function new(scene:GameScene, max:Int) {
		super(scene, max);

		//var lanza = new Weapon(this.scene, 10);
		this.setImage(Assets.getBitmapData("images/lanza_sprite_380x22.png"), 1, 4);
		//lanza.setBulletExplodeImage(Assets.getBitmapData("images/lanza_explotando.png"), 1, 4);
		//armas.setWeapon('lanza_e', lanza);
		this.setVelocity(150);
		this.setProbability(20);
		this.setDamage(20);
	}
/*
	override public function updateLogic(time:Float) {
		super.updateLogic(time);

		if (this.shootTimer <= 0) {
			// @todo: Deberia ser configurable el tiempo en disparos
			shootTimer = 5;
			armas.getWeapon('lanza').shoot(this,'left');
		}
	}
*/
}