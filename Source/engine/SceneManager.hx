package engine;

import flash.display.Sprite;
import flash.display.BitmapData;
import openfl.display.Tilesheet;
import flash.geom.Rectangle;
import flash.geom.Point;

/**
 * ...
 * @author fbricker
 */
class SceneManager extends GameElement {

	var currentScene:Scene;
	public var sceneMap(default, null):Map<String, Scene>;

	private function new() {
		super();
		currentScene = null;
		sceneMap = new Map<String,Scene>();
	}

	public function setScene(name:String) {
		
		if (!sceneMap.exists(name)) {
			// @todo: pasar a un errorManager
			trace(sceneMap);
			trace("LA ESCENA "+name+" NO EXISTE!");
			return;
		}

		if (currentScene != null) {
			// Borramos la escena actual...
			this.removeChild(currentScene);
			hijos.remove(currentScene);
			currentScene = null;
		}

		// Cargamos la nueva escena
		currentScene=sceneMap.get(name);
		this.addChild(currentScene);
		this.hijos.push(currentScene);
		currentScene.show();
	}


}