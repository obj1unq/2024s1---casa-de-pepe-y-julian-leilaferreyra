
object casa {
	var cantidadDeViveres = 50
	var monto = 0
	method romperAlgoDeValor(_monto){
		monto = monto + _monto
	}
	method tieneViveresSuficientes(){
		return cantidadDeViveres>= 40
	}
	method hayQueHacerReparaciones(){
		return monto != 0
	}
	method laCasaEstaEnOrden(){
		return self.tieneViveresSuficientes() && not self.hayQueHacerReparaciones()
	}
}
