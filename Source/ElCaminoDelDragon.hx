package;

/**
 * @author ldmichiels
 */
class ElCaminoDelDragon extends Sprite {

	public function new () {
		super();
		
		stage.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);

		InputManager.getInstance().suscribe(stage);		
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e) {

	}
		
}
