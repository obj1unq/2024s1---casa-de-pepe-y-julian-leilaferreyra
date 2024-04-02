object casaDePepeYJulian {

	var property porcentajeDeViveres = 50
	var property montoParaReparaciones = 0
	var property cuentaHogar = cuentaCorriente
	var mantenimientoAsignado = minimoEIndispensable
	var property calidadDeViveres = 0
	const porcentajeMinimoDeViveres = 40

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

	method cubrirGastos(monto) {
		cuentaHogar.extraerDinero(monto)
	}

	method hacerMantenimiento() {
		mantenimientoAsignado.mantenimiento(self, calidadDeViveres)
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

}

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
		self.cubrirReparaciones(casa)
	}

	method cubrirReparaciones(casa) {
		if (casa.saldoCuentaHogar() >= (casa.montoParaReparaciones() + 1000)) {
			casa.cubrirGastos(casa.montoParaReparaciones())
			casa.montoParaReparaciones(0)
		}
	}

}

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

	var property cuentaPrimaria = cuentaCorriente
	var property cuentaSecundaria = cuentaConGastos

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

	method depositarDinero(monto) {
		cuentaPrimaria.depositarDinero(monto)
	}

	method extrearDinero(monto) {
		if (cuentaPrimaria.saldo() >= monto) cuentaPrimaria.extraerDinero(monto) else cuentaSecundaria.extraerDinero(monto)
	}

}

