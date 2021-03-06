package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;

class ElCaminoDelDragon extends SceneManager {

	private static var instance:SceneManager = null;
	private var game:GameScene;
	private var rapidgame:GameSceneVeloz;
	private var menu:MenuScene;
	
	public static function getInstance():SceneManager{
		return instance;
	}

	public function new () {
		super();
		instance = this;

		// En cada frame vamos a ejecutar la function gameLoop
		stage.addEventListener(flash.events.Event.ENTER_FRAME, gameLoop);
		InputManager.getInstance().suscribe(stage);
		game = new GameScene();
		//rapidgame =  new GameSceneVeloz();
		menu = new MenuScene();

		sceneMap.set('game', game);
		//sceneMap.set('rapidgame', rapidgame);
		sceneMap.set('menu', menu);
		//sceneMap.set('ayuda',new HelpScene());

		// Empezamos en la escena del menu
		setScene('menu');
		stage.addEventListener(openfl.events.Event.RESIZE, onResize);
	}

	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e) {
		// Si buscamos 60 fps
		this.updateLogic(1/60);
	}
	
	public function onResize(_) {
		var s:Float = Math.min(stage.stageWidth / 800, stage.stageHeight / 600);
		this.scaleX = this.scaleY = s;
		this.x = (stage.stageWidth - 800 * s)/2;
		this.y = (stage.stageHeight - 600 * s)/2;
	}
}
