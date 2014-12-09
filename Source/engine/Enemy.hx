package engine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

/**
 * @author ldmichiels
 */
class Enemy extends GameElement {

	// Constants
	private var probability:Int;
	private var state:Bool;
	private var velocity:Int;
	private var credit:Int;
	private var damage:Int;
	
	private var scene:GameScene;
	private var image:Animation;
	private var explodeImage:Animation;

	private var armas:WeaponManager;

	public function new(scene:GameScene, max:Int) {
		super();
		this.scene = scene;
		this.velocity = 50;
		this.credit = 10;
		this.damage = 10;
		this.probability = 100;

		this.scene.hijos.push(this);
		this.scene.addChild(this);

		armas = WeaponManager.getInstance();
	
		state = false;
	}

	override public function updateLogic(time:Float) {
		if (!isActive())
			return;
		super.updateLogic(time);
		this.x -= this.velocity * time;
		this.x--;

		if (this.colision == 0 && this.x > -100) {
			
			if (this.image != null) 
				this.image.visible = true;
			if (this.explodeImage != null) 
				this.explodeImage.visible = false;
		} else {
			if (this.colision != 0) {
				// Suma el pntaje por haber sido eliminado
				Score.getInstance().setCurrentScore(Score.getInstance().getCurrentScore() + this.credit);
				//Vida.getInstance().setVida(Vida.getInstance().getVida() - this.damage);
			}
			this.die();
		}
	}

	public function setImage(img:BitmapData, r:Int, c:Int) {
		this.image = new Animation(img, r, c);
		this.addChild(this.image);
		hijos.push(this.image);
		this.image.visible = false;
	}

	public function setExplodeImage(eImg:BitmapData, r:Int, c:Int) {
		this.explodeImage = new Animation(eImg, r, c);
		this.addChild(this.explodeImage);
		hijos.push(this.explodeImage);
		this.explodeImage.visible = false;
	}

	public function die() {
		this.state = false;
		if (this.image != null) 
			this.image.visible = false;
		if (this.explodeImage != null) 
			this.explodeImage.visible = true;

		scene.hijos.remove(this);
		scene.removeChild(this);

		CollisionDetection.getInstance().unsubscribe(this);
		this.colision = 0;
	}

	public function atack() {
		this.state = true;
		if (this.image != null) 
			this.image.visible = true;
		if (this.explodeImage != null) 
			this.explodeImage.visible = false;

		scene.hijos.push(this);
		scene.addChild(this);

		// Todo enemigo es colisionable
		CollisionDetection.getInstance().subscribe(this);

		this.x = 1000;
		this.y = 50 + Std.random(400);
	}

	public function isActive():Bool {
		return this.state;
	}

	public function getScene():GameScene {
		return this.scene;
	}

	public function setProbability(p:Int):Bool {
		if (p > 0 && p < 100) 
		     this.probability = p;
		else
			return false;
		return true;
	}

	public function getProbability():Int {
		return this.probability;
	}

	public function setCredit(c:Int) {
		this.credit = c;
	}

	public function getCredit() {
		return this.credit;
	}

	public function setVelocity(v:Int) {
		this.velocity = v;
	}

	public function getVelocity() {
		return this.velocity;
	}


	public function setDamage(d:Int) {
		this.damage = d;
	}

	public function getDamage() {
		return this.damage;
	}
}