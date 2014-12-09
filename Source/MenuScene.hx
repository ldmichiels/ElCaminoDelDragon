package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
import motion.Actuate;
import motion.MotionPath;
import motion.easing.*;
import openfl.utils.Timer;
import openfl.text.TextField;
import openfl.text.TextFormat;

class MenuScene extends Scene {

	// Botones dentro del Menu
	var jugar:BotonAnimado;
	var ayuda:Boton;
	var fondo:Bitmap;
	var puntaje:TextField;

	private var t:flash.utils.Timer;

	public function new() {
		super();

		fondo = new Bitmap (Assets.getBitmapData("images/menu.png"));
		this.addChild(fondo);
		fondo.visible = true;
		fondo.x = fondo.y = 0;

		var w:Int = 200;
		var h:Int = 50;

		t= new Timer(10, 2);
		jugar = new BotonAnimado("images/PlayButton.png",158,30, w, h,3, play);
		this.addChild(jugar);

		puntaje = new TextField();
		puntaje.selectable=false;
		puntaje.width=300;
		puntaje.height=100;

		var tf = new TextFormat('Arial', 30, 0xFFFFFF);
		puntaje.setTextFormat(tf);
		puntaje.defaultTextFormat = tf;

		//#if (ios || html5)
		this.addChild(puntaje);
		//#end

/*
		jugar = new Boton(0x760b38, w, h, play);
		jugar.setText("Jugar");
		ayuda = new Boton(0x760b38, w, h, help);
		ayuda.setText("Ayuda");
		this.addChild(jugar);
		this.addChild(ayuda);
*/
		jugar.x = 600;
		jugar.y = 400;
/*
		ayuda.x = 600;
		ayuda.y = 500;
*/
	}

	public function play(_) {
		ElCaminoDelDragon.getInstance().setScene('game');
	}

	public function help(_) {
		//ElCaminoDelDragon.getInstanºce().setScene('help');
	}

	override public function show() {
		/*
		jugar.scaleX = jugar.scaleY = 20;
		jugar.alpha = 0;
		motion.Actuate.tween(jugar, 0.2, {scaleX:1, scaleY:1, alpha:1}).delay(0.5);

		ayuda.scaleX = ayuda.scaleY = 20;
		ayuda.alpha = 0;
		motion.Actuate.tween(ayuda, 0.2, {scaleX:1, scaleY:1, alpha:1}).delay(0.5);

		//ayuda.rotation = 360;
		//ayuda.alpha = 0;
		//jugar.scaleX = jugar.scaleY = 0;
		//motion.Actuate.tween(ayuda, 3, {scaleX:1, scaleY:1, alpha:1}).delay(0.3);
		*/

		puntaje.text = 'MAX SCORE: ' + Score.getInstance().getMaxScore();
	}

}