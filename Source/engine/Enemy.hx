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

	// @todo: Deberia usar hijos en lugar de deinir un nuevo arreglo
	
	private var scene:GameScene;
	private var image:Animation;
	private var explodeImage:Animation;

	private var armas:WeaponManager;

	private var state:Bool;
	private var velocity:Int;

	public function new(scene:GameScene, max:Int) {
		super();
		this.scene = scene;
		this.velocity = 50;
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
		//this.x -= this.velocity * time;
		this.x--;

		if (this.colision == 0 && this.x > -100) {
			
			if (this.image != null) 
				this.image.visible = true;
			if (this.explodeImage != null) 
				this.explodeImage.visible = false;
		} else {
			this.die();
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

	public function die() {
		this.state = false;
		if (this.image != null) 
			this.image.visible = false;
		if (this.explodeImage != null) 
			this.explodeImage.visible = true;
		this.colision = 0;
		CollisionDetection.getInstance().unsubscribe(this);
	}

	public function atack() {
		this.state = true;
		if (this.image != null) 
			this.image.visible = true;
		if (this.explodeImage != null) 
			this.explodeImage.visible = false;
		// Todo enemigo es colisionable
		CollisionDetection.getInstance().subscribe(this);

		this.x = 1000;
		this.y = 50 + Std.random(500);
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

}