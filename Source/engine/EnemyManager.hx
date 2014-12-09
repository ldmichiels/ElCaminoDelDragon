package engine;

import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import Lambda;

/**
 * @author ldmichiels
 */
class EnemyManager extends GameElement {

	private var enemies:Map<String, Array<Enemy>>;
	private var activeEnemies:Array<Enemy>;

	private static var instance:EnemyManager = null;

	private var enemyTimer:Float;

	private function new(){
		super();
		enemies = new Map<String, Array<Enemy>>();
		activeEnemies = new Array<Enemy>();
		enemyTimer = 0;
	}

	public static function getInstance():EnemyManager {
		if (instance == null)
			instance = new EnemyManager();
		return instance;
	}

	override public function updateLogic(time:Float) {
		//super.updateLogic(time);

		enemyTimer -= time;
		if (enemyTimer < 0) {
			// Valor entre 2 y 5 segundos
			//enemyTimer = Std.random(3) + 2;
			enemyTimer = Std.random(1) + 0.5;

			this.turnOnEnemies();
		}
	}
/*
	public function createEnemies(name:String, enemy:Enemy, cant:Int) {
		var arr_enemies = new Array<Enemy>();
		var s:GameScene = enemy.getScene();
		var m:Int = enemy.getMax();
		var c:String = Type.getClassName(Type.getClass(enemy));

		for (i in 0 ... cant) {
			//var emy = new Enemy(s, m);
			//var emy = enemy;
			var emy = Type.createInstance(Type.resolveClass(c),[s,m]);
			arr_enemies.push(emy);
			}
		this.enemies.set(name, arr_enemies);
	}
*/
	public function countActiveEnemies():Int {
		return this.activeEnemies.length;
	}

	public function countEnemyTypes():Int {
		return Lambda.count(this.enemies);
	}

	//public function turnOnEnemies(key:String) {
	private function turnOnEnemies() {
		/*var arr_enemies = this.enemies.get(key);
		for (e in arr_enemies) {
			e.atack();
			this.activeEnemies.push(e);
		}*/
		
		var r:Int = Std.random(this.countEnemyTypes());
		var count:Int = 0;
		// Selecciona el tipo de enemigo al azar (igual probabilidad para todos)
		for (key in enemies.keys()) {
			if (count == r) {
				var emy = enemies.get(key);
				
				// Recorremos el arreglode enemigos de ete tipo
				for (e in emy) {
					r = Std.random(100);
					if (!e.isActive() && r < e.getProbability()) {
					//if (!e.isActive()){
						e.atack();
						this.activeEnemies.push(e);
						return;
					}
				}
			} else count++;
		}
	}

	public function addEnemies(n:String, e:Array<Enemy>) {
		this.enemies.set(n, e);
	}

}