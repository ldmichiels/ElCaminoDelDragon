package engine;

class Score {

	private static var instance:Score = null;
	private var puntaje:Int;
	private static var data:openfl.net.SharedObject = null;

	private function new() {
		puntaje = 0;
		data = openfl.net.SharedObject.getLocal('storage');
		this.setCurrentScore(0);
	}

	public static function getInstance():Score {
		if (instance == null)
			instance = new Score();
		return instance;
	}

	public function setCurrentScore(score:Int) {
		data.data.cscore = score;
		try{
			data.flush();
		}catch(e:Dynamic){
			trace("ERROR AL PERSISTIR PUNTAJE: " + e);
		}
	}

	public function getCurrentScore():Int {
		if (data.data == null)
			return 0;
		if (data.data.cscore == null)
			return 0;
		return data.data.cscore;
	}

	public function setMaxScore(score:Int) {
		if (this.getMaxScore() >= score)
			return;
		data.data.mscore = score;
		try{
			data.flush();
		}catch(e:Dynamic){
			trace("ERROR AL PERSISTIR PUNTAJE: " + e);
		}
	}

	public function getMaxScore():Int {
		if (data.data == null)
			return 0;
		if (data.data.mscore == null)
			return 0;
		return data.data.mscore;
	}

}