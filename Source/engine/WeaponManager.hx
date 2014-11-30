package engine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

/**
 * @author ldmichiels
 */
class WeaponManager extends GameElement {
	// @todo: weapons podria tener un struct dnd tmb se incluya el dueño
	private var weapons:Map<String, Weapon>;
	private static var instance:WeaponManager = null;

	private function new(){
		super();
		weapons = new Map<String, Weapon>();
	}

	public static function getInstance():WeaponManager {
		if (instance == null)
			instance = new WeaponManager();
		return instance;
	}

	override public function updateLogic(time:Float) {
		super.updateLogic(time);

		for (key in weapons.keys()) {
			var wpn = weapons.get(key);
			if (wpn.isActive())
				wpn.updateLogic(time);
		}
	}

	public function getWeapon(name:String) {
		return weapons.get(name);
	}

	public function setWeapon(name:String, wpn: Weapon) {
		if (!weapons.exists(name)) 
			weapons.set(name, wpn);
		else 
			//generar error
			return false;
		return true;
	}

	public function createWeapon(name:String, scene:GameScene) {
		// @todo: hay q sacar esta constante
		var wpn = new Weapon(scene, 10);
		return this.setWeapon(name, wpn);
	}
}