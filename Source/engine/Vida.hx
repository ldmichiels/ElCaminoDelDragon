package engine;

class Vida {

	private static var instance:Vida = null;
	private var porcentaje:Int;
	private static var data:openfl.net.SharedObject = null;

	private function new() {
		porcentaje = 100;
		data = openfl.net.SharedObject.getLocal('storage');
		this.setVida(100);
	}

	public static function getInstance():Vida {
		if (instance == null)
			instance = new Vida();
		return instance;
	}

	public function setVida(vida:Int) {
		data.data.vida = vida;
		try{
			data.flush();
		}catch(e:Dynamic){
			trace("ERROR AL PERSISTIR VIDA: " + e);
		}
	}

	public function getVida():Int {
		if (data.data == null)
			return 0;
		if (data.data.vida == null)
			return 0;
		return data.data.vida;
	}
}