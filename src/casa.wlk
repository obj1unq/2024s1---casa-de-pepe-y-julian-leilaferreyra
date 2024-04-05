object casaDePepeYJulian {

	var property porcentajeDeViveres = 0
	const porcentajeMinimoDeViveres = 40
	var calidadDeViveres = 0
	var property montoParaReparaciones = 0
	var cuentaHogar = cuentaCorriente
	var estrategiaDeAhorro = minimoEIndispensable

	method tieneViveresSuficientes() {
		return porcentajeDeViveres >= porcentajeMinimoDeViveres
	}

	method hayQueHacerReparaciones() {
		return montoParaReparaciones > 0
	}

	method laCasaEstaEnOrden() {
		return self.tieneViveresSuficientes() && not self.hayQueHacerReparaciones()
	}

	method romperAlgoDeValor(monto) {
		montoParaReparaciones += monto
	}

	method hacerMantenimiento() {
		estrategiaDeAhorro.mantenimiento(self, calidadDeViveres)
	}

	method cubrirGastos(monto) {
		cuentaHogar.extraerDinero(monto)
	}

	method sumarAPorcentajeDeViveres(cantidad) {
		porcentajeDeViveres += cantidad
	}

	method saldoCuentaHogar() {
		return cuentaHogar.saldo()
	}

	method estrategiaDeAhorro(_estrategiaDeAhorro) {
		estrategiaDeAhorro = _estrategiaDeAhorro
	}

	method calidadDeViveres(_calidadDeViveres) {
		calidadDeViveres = _calidadDeViveres
	}

	method cuentaHogar(_cuentaHogar) {
		cuentaHogar = _cuentaHogar
	}

}

//ESTRATEGIAS DE AHORRO.
object minimoEIndispensable {

	const porcentajeMinimoDeViveres = 40

	method mantenimiento(casa, calidad) {
		casa.cubrirGastos(self.viveresFaltantes(casa) * calidad)
		casa.porcentajeDeViveres(porcentajeMinimoDeViveres)
	}

	method viveresFaltantes(casa) {
		return porcentajeMinimoDeViveres - casa.porcentajeDeViveres()
	}

}

object full {

	const calidadFull = 5
	const porcentajeMaximoDeViveres = 100

	method mantenimiento(casa, calidad) {
		self.mantenimientoDeViveresFull(casa)
		self.cubrirReparacionesSiSePuede(casa)
	}

	method mantenimientoDeViveresFull(casa) {
		if (casa.laCasaEstaEnOrden()) {
			casa.cubrirGastos(self.viveresFaltantes(casa) * calidadFull)
			casa.porcentajeDeViveres(porcentajeMaximoDeViveres)
		} else {
			casa.sumarAPorcentajeDeViveres(40)
			casa.cubrirGastos(40 * calidadFull)
		}
	}

	method cubrirReparacionesSiSePuede(casa) {
		if (self.sePuedenHacerReparaciones(casa)) {
			self.cubrirReparaciones(casa)
		}
	}

	method cubrirReparaciones(casa) {
		casa.cubrirGastos(casa.montoParaReparaciones())
		casa.montoParaReparaciones(0)
	}

	method sePuedenHacerReparaciones(casa) {
		return casa.saldoCuentaHogar() >= casa.montoParaReparaciones() + 1000
	}

	method viveresFaltantes(casa) {
		return porcentajeMaximoDeViveres - casa.porcentajeDeViveres()
	}

}

//CUENTAS.
object cuentaCorriente {

	var saldo = 0

	method saldo() {
		return saldo
	}

	method depositarDinero(monto) {
		saldo += monto
	}

	method extraerDinero(monto) {
		saldo -= monto
	}

}

object cuentaConGastos {

	var saldo = 0
	var costoPorOperacion = 0

	method saldo() {
		return saldo
	}

	method depositarDinero(monto) {
		saldo = saldo + monto - costoPorOperacion
	}

	method extraerDinero(monto) {
		saldo -= monto
	}

	method costoPorOperacion(_costoPorOperacion) {
		costoPorOperacion = _costoPorOperacion
	}

}

object cuentaCombinada {

	var cuentaPrimaria = cuentaCorriente
	var cuentaSecundaria = cuentaConGastos

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

	method depositarDinero(monto) {
		cuentaPrimaria.depositarDinero(monto)
	}

	method extraerDinero(monto) {
		if (cuentaPrimaria.saldo() >= monto) {
			cuentaPrimaria.extraerDinero(monto)
		} else {
			cuentaSecundaria.extraerDinero(monto)
		}
	}

	method cuentaPrimaria(_cuentaPrimaria) {
		cuentaPrimaria = _cuentaPrimaria
	}

	method cuentaSecundaria(_cuentaSecundaria) {
		cuentaSecundaria = _cuentaSecundaria
	}

}

