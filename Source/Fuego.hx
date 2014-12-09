package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import engine.*;

/**
 * @author ldmichiels
 */
class Fuego extends Enemy {


	public function new(scene:GameScene, max:Int) {
		super(scene, max);

		//var lanza = new Weapon(this.scene, 10);
		this.setImage(Assets.getBitmapData("images/fuego.png"), 1, 4);
		this.setCredit(30);
		this.setDamage(20);
		this.setVelocity(100);
		this.setProbability(20);
		//lanza.setBulletExplodeImage(Assets.getBitmapData("images/lanza_explotando.png"), 1, 4);
		//armas.setWeapon('lanza_e', lanza);
	}
}