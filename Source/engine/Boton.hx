package engine;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.events.Event;

class Boton extends Sprite {

	private var tfield:TextField = null;
	private var tformat:TextFormat = null;

	public function new(color:Int, w:Int, h:Int, callback:Event->Void){
		super();
		this.graphics.beginFill(color);
		this.graphics.drawRect(0, 0, w, h);
		this.graphics.endFill();
		this.addEventListener(openfl.events.MouseEvent.CLICK, callback);

		tfield = new TextField();
		tfield.selectable = false;
		// Le restamos el 10% del ancho del boton para q el texto no quede en el borde
		tfield.width = w - (0.1 * w);
		tfield.height = h - (0.1 * h);

		tformat = new TextFormat('Arial', 30, 0xFFFFFF);
		tfield.setTextFormat(tformat);
		tfield.defaultTextFormat = tformat;

		this.addChild(tfield);
	}

	public function setText(txt:String) {
		this.tfield.text = txt;
	}

	public function setTextFormat(tf:TextFormat) {
		this.tformat = tf;
	}

}