package engine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

/**
 * @author ldmichiels
 */
class Bullet extends GameElement {

	private static var waiting:Int = 0;
	private static var active:Int = 1;
	private static var exploiting:Int = 2;

	//private var visible:Bool;
	private var state:Int;
	private var way:String;
	private var velocity:Int;

	private var image:Animation = null;
	private var explodeImage:Animation = null;
	private var scene:GameScene;

	public function new(s:GameScene) {
		super();
		this.scene = s;
		// Managing visual
		scene.hijos.push(this);
		scene.addChild(this);
		
		//this.visible = false;
		this.state = waiting;
		this.velocity = 80;
		//this.x = 0;
		//this.y = 0;
		CollisionDetection.getInstance().subscribe(this);
	}

	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		if (way == 'left')
			this.x -= velocity * time;
		else
			this.x += velocity * time;

		switch (state) {
			case 1: 
				// active
				if (this.colision == 0) {
					if (this.explodeImage != null)
						this.explodeImage.visible = false;
					if (this.image != null)
						this.image.visible = true;
				} else {
					this.state = exploiting;
				}
			case 2:
				// exploiting
				if (this.image != null)
					this.image.visible = false;
				if (this.explodeImage != null)
					this.explodeImage.visible = true;

				//@todo: hay q arreglar esta constante
				if (this.explodeImage.getFrame() == 3) {
					this.explodeImage.visible = false;
					this.setState(waiting);
				}
			default:
				// waiting
				this.image.visible = false;
				this.explodeImage.visible = false;
				this.colision = 0;
		}

		if (this.x > 810)
			this.disactivate();
	}


	public function explode() {
		this.setState(exploiting);
	}

	public function activate() {
		this.setState(active);
		//this.setVisible(true);
	}

	public function disactivate() {
		this.setState(waiting);
		//this.setX(0);
		//this.setY(0);
	}

	public function isActive() {
		if (this.state == 0) 
			return false;
		return true;
	}

	/**
	 *  Getters & Setters
	 */

	public function setImage(img:BitmapData, r:Int, c:Int) {
		this.image = new Animation(img, r, c);
		this.image.visible = false;
		this.addChild(this.image);
		hijos.push(this.image);
	}

	public function setExplodeImage(eImg:BitmapData, r:Int, c:Int) {
		this.explodeImage = new Animation(eImg, r, c);
		this.explodeImage.visible = false;
		this.addChild(this.explodeImage);
		hijos.push(this.explodeImage);
	}

	private function setState(s:Int) {
		switch (s) {
			case 1: 
				this.state = s;
				CollisionDetection.getInstance().subscribe(this);
			case 2: 
				this.state = s;
				CollisionDetection.getInstance().subscribe(this);
			// Si el valor no es 1 o 2, se asume 0
			default: this.state = waiting;
		}
	}

	public function getState() {
		return this.state;
	}

	public function setX(x:Float) {
		this.x = x;
	}

	public function setY(y:Float) {
		this.y = y;
	}

	public function getWay():String {
		return this.way;
	}

	public function setWay(w:String) {
		return this.way = w;
	}

	public function getVelocity():Int {
		return this.velocity;
	}

	public function setVelocity(v:Int) {
		return this.velocity = v;
	}
}