package engine;


class CollisionDetection {
	
	private var colliders:Array<GameElement> = null;
	private static var instance:CollisionDetection = null;
	
	public static function getInstance():CollisionDetection {
		if (instance == null) {
			instance = new CollisionDetection();
		}
		return instance;
	}

	private function new(){
		this.colliders = new Array<GameElement>();
	}

	public function subscribe(obj:GameElement):Int {
		return this.colliders.push(obj);
	}

	public function unsubscribe(obj:GameElement):Bool {
		return this.colliders.remove(obj);
	}

	// Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    public static function detectarColision(obj1:GameElement, obj2:GameElement):Bool {
		
		if (obj1.x + obj1.width > obj2.x && obj1.x < obj2.x + obj2.width){
		   	if(obj1.y + obj1.height > obj2.y && obj1.y < obj2.y + obj2.height){
		   		// Hay colision
		   		return true;
		   	}
		}
		// No hay colision
		return false;
    }

    // Detecta si obj1 colisiona con algun elemento del arreglo colliders
    public static function detectarColision2(obj1:GameElement):Bool {
		for (obj2 in CollisionDetection.getInstance().colliders) {
			if (obj1.x + obj1.width > obj2.x && obj1.x < obj2.x + obj2.width){
			   	if(obj1.y + obj1.height > obj2.y && obj1.y < obj2.y + obj2.height){
			   		// Hay colision
			   		obj2.setColision(obj2.getColision()+1);
			   		return true;
			   	}
			}
		}
		// No hay colision
		return false;
    }

    // Detecta si cada par de objetos del arreglo coolliders colisionan
    public static function detectarColision3() {
		for (obj1 in CollisionDetection.getInstance().colliders) {
			for (obj2 in CollisionDetection.getInstance().colliders) {
				if (obj1 != obj2 && obj1.x + obj1.width > obj2.x && obj1.x < obj2.x + obj2.width){
				   	if(obj1.y + obj1.height > obj2.y && obj1.y < obj2.y + obj2.height){
				   		// Hay colision, avisar a los objetos
				   		obj1.setColision(obj1.getColision()+1);
				   		obj2.setColision(obj2.getColision()+1);
				   	}
				}
			}
		}
    }

}