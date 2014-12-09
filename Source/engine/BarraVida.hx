package engine;

class BarraVida extends GameElement {

	private var porcentaje:Int;
	private var ancho:Int;
	private var alto:Int;

	public function new(x:Float, y:Float) {
		super();
		ancho = 110;
		alto = 20;
		this.x = x;
		this.y = y;

		this.graphics.beginFill(0x000000);
		this.graphics.drawRect(this.x, this.y, ancho, alto);
		this.graphics.endFill();

		this.graphics.beginFill(0xfacade);
		this.graphics.drawRect(this.x + 5, this.y + 5, 100, 10);
		this.graphics.endFill();

		porcentaje = Vida.getInstance().getVida();
	}

	override public function updateLogic(time:Float) {
		super.updateLogic( time );

		if (porcentaje != Vida.getInstance().getVida()) {
			this.graphics.clear();
			
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(this.x, this.y, ancho, alto);
			this.graphics.endFill();

			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(this.x + 5, this.y + 5, 100, 10);
			this.graphics.endFill();

			this.graphics.beginFill(0xfacade);
			this.graphics.drawRect(this.x + 5, this.y + 5, Vida.getInstance().getVida(), 10);
			this.graphics.endFill();
		}
	}

}

