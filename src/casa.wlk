object casaDePepeYJulian {

	var property porcentajeDeViveres = 50
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

	method viveresFaltantes() {
		return if (porcentajeDeViveres < porcentajeMinimoDeViveres) {
			porcentajeMinimoDeViveres - porcentajeDeViveres
		} else {
			0
		}
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

//ESTRATEGIAS DE AHORRO 
object minimoEIndispensable {

	const porcentajeMinimoDeViveres = 40

	method mantenimiento(casa, calidad) {
		casa.cubrirGastos(casa.viveresFaltantes() * calidad)
		casa.porcentajeDeViveres(porcentajeMinimoDeViveres)
	}

}

object full {

	const calidadFull = 5

	method mantenimiento(casa, calidad) {
		if (casa.laCasaEstaEnOrden()) {
			casa.porcentajeDeViveres(100)
		} else {
			casa.sumarAPorcentajeDeViveres(40)
			casa.cubrirGastos(40 * calidadFull)
		}
		self.cubrirReparacionesSiSePuede(casa)
	}

	method cubrirReparacionesSiSePuede(casa) {
		if (casa.saldoCuentaHogar() >= (casa.montoParaReparaciones() + 1000)) {
			casa.cubrirGastos(casa.montoParaReparaciones())
			casa.montoParaReparaciones(0)
		}
	}

}

//CUENTAS
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
		if (cuentaPrimaria.saldo() >= monto) cuentaPrimaria.extraerDinero(monto) else cuentaSecundaria.extraerDinero(monto)
	}

	method cuentaPrimaria(_cuentaPrimaria) {
		cuentaPrimaria = _cuentaPrimaria
	}

	method cuentaSecundaria(_cuentaSecundaria) {
		cuentaSecundaria = _cuentaSecundaria
	}

}

