object casaDePepeYJulian {

	var property porcentajeDeViveres = 50
	const porcentajeMinimoDeViveres = 40
	var property calidadDeViveres = 0
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
		estrategiaDeAhorro.mantenimiento(self)
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

	method mantenimiento(casa) {
		casa.cubrirGastos(self.presupuestoDeMantenimiento(casa))
		casa.porcentajeDeViveres(porcentajeMinimoDeViveres)
	}

	method presupuestoDeMantenimiento(casa) {
		return self.viveresFaltantes(casa) * casa.calidadDeViveres()
	}

	method viveresFaltantes(casa) {
		return porcentajeMinimoDeViveres - casa.porcentajeDeViveres()
	}

}

object full {

	const calidadFull = 5
	const porcentajeMaximoDeViveres = 100

	method mantenimiento(casa) {
		self.mantenimientoDeViveresFull(casa)
		self.cubrirReparacionesSiSePuede(casa)
	}

	method mantenimientoDeViveresFull(casa) {
		if (casa.laCasaEstaEnOrden()) {
			self.viveresAl100(casa)
		} else {
			self.viveresMas40(casa)
		}
	}

	method viveresAl100(casa) {
		casa.cubrirGastos(self.presupuestoDeMantenimiento(casa))
		casa.porcentajeDeViveres(porcentajeMaximoDeViveres)
	}

	method viveresMas40(casa) {
		casa.cubrirGastos(self.presupuestoDeMantenimiento(casa))
		casa.sumarAPorcentajeDeViveres(40)
	}

	method presupuestoDeMantenimiento(casa) {
		return if (casa.laCasaEstaEnOrden()) {
			self.viveresFaltantes(casa) * calidadFull
		} else {
			40 * calidadFull
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
		saldo += (monto - costoPorOperacion)
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

