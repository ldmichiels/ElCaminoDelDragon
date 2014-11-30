package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
import motion.Actuate;
import motion.MotionPath;
import motion.easing.*;
/**
 * ...
 * @author fbricker
 */
class MenuScene extends Scene {

	// Botones dentro del Menu
	var jugar:Boton;
	var ayuda:Boton;

	public function new() {
		super();
		var w:Int = 200;
		var h:Int = 50;
		jugar = new Boton(0xFF0000, w, h, play);
		jugar.setText("Jugar");
		ayuda = new Boton(0x00FF00, w, h, help);
		ayuda.setText("Ayuda");
		this.addChild(jugar);
		this.addChild(ayuda);

		jugar.x = 300;
		jugar.y = 200;

		ayuda.x = 300;
		ayuda.y = 400;
	}

	public function play(_) {
		ElCaminoDelDragon.getInstance().setScene('game');
	}

	public function help(_) {
		//ElCaminoDelDragon.getInstanºce().setScene('help');
	}

	override public function show() {
		jugar.scaleX = jugar.scaleY = 20;
		jugar.alpha = 0;
		motion.Actuate.tween(jugar, 0.2, {scaleX:1, scaleY:1, alpha:1});

		ayuda.rotation = 360;
		ayuda.alpha = 0;
		motion.Actuate.tween(ayuda, 3, {rotation:0, alpha:1}).delay(0.3);
	}

}