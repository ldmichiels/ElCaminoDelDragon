package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;

class ElCaminoDelDragon extends SceneManager {

	private static var instance:SceneManager = null;
	
	public static function getInstance():SceneManager{
		return instance;
	}

	public function new () {
		super();
		instance = this;

		// En cada frame vamos a ejecutar la function gameLoop
		stage.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);
		InputManager.getInstance().suscribe(stage);

		sceneMap.set('game', new GameScene());
		sceneMap.set('menu', new MenuScene());
		//sceneMap.set('ayuda',new HelpScene());

		// Empezamos en la escena del menu
		setScene('menu');
	}

	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e) {
		// Si buscamos 60 fps
		this.updateLogic(1/60);
	}
		
}
