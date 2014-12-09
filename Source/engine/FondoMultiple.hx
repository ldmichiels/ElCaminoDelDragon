package engine;

import openfl.display.Bitmap;
import openfl.Assets;

class FondoMultiple extends GameElement {

	public var vel:Float;
	public var bitmaps:Array<Bitmap>;
	public var ancho_total:Float;

	public function new(bms:Array<Bitmap>, velocidad:Float){
		super();
		this.bitmaps = bms;

		var pos:Float = 0;
		for (bit in bitmaps) {
			addChild(bit);
			bit.x = pos;
			pos += bit.width;
		}
		ancho_total = pos;
		vel = velocidad;
	}

	override function updateLogic(time:Float){
		super.updateLogic(time);

		for (bit in bitmaps) {
			bit.x -= time * vel;
			if(bit.x < bit.width * -1)
				bit.x += ancho_total;
		}
	}
}