package engine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

/**
 * @author ldmichiels
 */
class Weapon extends GameElement {

	// Constants
	private var max_bullets:Int;
	private var time_btwn_shots:Int;

	// @todo: Deberia usar hijos en lugar de deinir un nuevo arreglo
	private var bullets:Array<Bullet>;
	private var scene:GameScene;
	private var image:Animation;
	private var explodeImage:Animation;

	private var state:Bool;


	public function new(scene:GameScene, max:Int) {
		super();
		this.scene = scene;
		max_bullets = max;
		time_btwn_shots = 5;
		bullets = new Array<Bullet>();

		// Loading the weapon
		for (i in 0...max_bullets) {
			var blt = new Bullet(this.scene);

			// Managing logic
			bullets.push(blt);
		}

		state = true;
	}

	override public function updateLogic(time:Float) {
		super.updateLogic(time);

		// Managing logic
		for (blt in bullets) {
			blt.updateLogic(time);
		}
	}

	public function setImage(img:BitmapData, r:Int, c:Int) {
		this.image = new Animation(img, r, c);
		this.addChild(this.image);
		hijos.push(this.image);
	}

	public function setExplodeImage(eImg:BitmapData, r:Int, c:Int) {
		this.explodeImage = new Animation(eImg, r, c);
		this.addChild(this.explodeImage);
		hijos.push(this.explodeImage);
	}

	public function setTimeBtwnShots(t:Int) {
		if (t > 0)
			this.time_btwn_shots = t;
		else
			// show an error
			return false;
		return false;
	}

	public function setBulletImage(img:BitmapData, r:Int, c:Int) {
		for (blt in bullets) {
			blt.setImage(img, r, c);
		}
	}

	public function setBulletExplodeImage(img:BitmapData, r:Int, c:Int) {
		for (blt in bullets) {
			blt.setExplodeImage(img, r, c);
		}
	}

	// Si puede o no puede disparar se debe controlar aca.
	public function shoot(shooter:GameElement, way:String) {
		if (this.isActive()) {
			var b:Bullet = this.getBullet();
			if (b != null) {
				b.setX(shooter.x + 90);
				b.setY(shooter.y + 25);
				b.setWay(way);
				b.activate();
			}
		}
	}

	public function reload() {
		/*var it = bullets.iterator();
		for (it.hasNext()) {
			it.next().setVisible(true);
		}*/
	}

	public function isActive():Bool {
		return this.state;
	}

	public function haveBullets():Bool {
		
		for (blt in bullets) {
			if (blt.isActive())
				return true;
		}
		return false;
	}

	public function getBullet():Bullet {
		for (blt in bullets) {
			if (!blt.isActive())
				return blt;
		}
		return null;
	}

}