package engine;

import flash.display.Sprite;

class GameElement extends Sprite{
	
	var hijos:Array<GameElement>;
	var colision:Int = 0;
	
	public function new () {
		super();		
		hijos= new Array<GameElement>();
	}
	
	public function updateLogic(time:Float){
		var hijo:GameElement;
		for (hijo in hijos) {
			hijo.updateLogic(time);
		}
	}

	public function getColision():Int {
		return colision;
	}

	public function setColision(c:Int) {
		this.colision = c;
	}
}
