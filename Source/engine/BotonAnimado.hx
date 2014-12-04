package engine;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.events.Event;
import flash.display.BitmapData;
import openfl.Assets;
import flash.display.Bitmap;
import openfl.display.Tilesheet;
import flash.geom.Rectangle;

class BotonAnimado extends Sprite {

	//private var tfield:TextField = null;
	//private var tformat:TextFormat = null;
	private var t:Tilesheet;
    private var  imgBoton:BitmapData;
	
	public function new( pathImg:String, w:Int, h:Int,x:Int,y:Int,c:Int, callback:Event->Void){//,callbackMO:Event->Void){
		super();
		this.x = x;
		this.y = y;
		var cant:Int;
	 	imgBoton= Assets.getBitmapData(pathImg);
		t=new Tilesheet(imgBoton);
		for(cant in 0 ... c) {
		t.addTileRect(new Rectangle(0,h*cant,w,h));
		}
		t.drawTiles(graphics,[0,0,0]);
		this.addEventListener(openfl.events.MouseEvent.CLICK, cambia3);
		this.addEventListener(openfl.events.MouseEvent.CLICK, callback);
		this.addEventListener(openfl.events.MouseEvent.MOUSE_OVER, cambia);
		this.addEventListener(openfl.events.MouseEvent.MOUSE_OUT, cambia2);

	}

//public function changeImg(String Path){
//	imgBoton.graphics.
//}
public function cambia(event:openfl.events.MouseEvent){
	t.drawTiles(graphics,[0,0,1]);	
}


public function cambia2(event:openfl.events.MouseEvent){
	t.drawTiles(graphics,[0,0,0]);	
}

public function cambia3(event:openfl.events.MouseEvent){
	t.drawTiles(graphics,[0,0,2]);	

}
}