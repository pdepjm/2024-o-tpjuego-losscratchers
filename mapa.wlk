import items.*
import alf.*
import enemigo.*
import HUD.*

class Puerta {
    var property image = "puerta-ancha.png"
    const property position
    var property estaCerrada
    var property habitacionOrigen = 0
    var property habitacionDestino = 0
    var property puertaDestino = 0

    method asignarHabitaciones(origen, destino) {
        habitacionOrigen = origen
        habitacionDestino = destino
    }

    method asignarPuertaDestino(destino) {
        puertaDestino = destino
    }

    method cambiarCelda() {
        if (habitacionOrigen.enemigosDisponibles().size() == 0 && habitacionOrigen.itemsDisponibles().size() == 0) {
            // Elimina las puertas, y todos los items y enemigos que quedaron restando en la celda
            habitacionOrigen.puertasDisponibles().forEach { puerta => game.removeVisual(puerta) }
            habitacionOrigen.itemsDisponibles().forEach { item => game.removeVisual(item) }
            habitacionOrigen.enemigosDisponibles().forEach { enemigo => game.removeVisual(enemigo) }
            
            // Generamos las puertas, items y enemigos para que aparezcan en la nueva celda
            habitacionDestino.generarPuertas()
            habitacionDestino.generarEnemigos()
            habitacionDestino.generarItems()

            // Mover a Alf
            alf.position(puertaDestino.position())
            alf.habitacionActual(habitacionDestino)
            alf.habitacionActual.generarAlf()

            // Reiniciar enemigos
            habitacionDestino.refrescarEnemigos()
        }
    }
}

class Habitacion {
    // Usar remove items cuando se utilizan y enemigos cuando se mueren
    const property puertasDisponibles = []
    const property itemsDisponibles = []
    const property enemigosDisponibles = []
    
    method generarPuertas() {
        puertasDisponibles.forEach { puerta => game.addVisual(puerta) }
    }

    method generarItems() {
        itemsDisponibles.forEach { item => game.addVisual(item) }
    }
    
    method generarEnemigos() {
        enemigosDisponibles.forEach{ enemigo => game.addVisual(enemigo) }
    }

    method generarAlf()
    {
        game.removeVisual(alf)
        game.addVisualCharacter(alf)
    }

    method generarHabitacion() {
        self.generarPuertas()
        self.generarItems()
        self.generarEnemigos()
        self.generarAlf()
        game.ground("celda.png") // Fondo
    }

    method refrescarEnemigos() {
        alf.habitacionActual().enemigosDisponibles().forEach { enemigoActual => game.whenCollideDo(enemigoActual, {alf => 
            enemigoActual.atacar(alf)
        })}
        alf.habitacionActual().enemigosDisponibles().forEach { enemigoActual => game.onTick(3000,"Cooldown",{enemigoActual.puedoAtacar(true)}) }
        alf.habitacionActual().enemigosDisponibles().forEach { enemigoActual => game.onTick(1100, "movimiento", {enemigoActual.movete()}) }
        alf.habitacionActual().enemigosDisponibles().forEach { enemigoActual => keyboard.z().onPressDo({ alf.atacar(enemigoActual) }) }
    }

    // method puertaConectada(listaPuertasOrigen, listaPuertasDestino) = listaPuertasOrigen.puertasDisponibles().find { puertaDestino => (puertaOrigen.position().x() == puertaDestino.position().x()) or (puertaOrigen.position().y() == puertaDestino.position().y())}
}

// Puertas
const puerta1 = new Puerta(estaCerrada = false, position = game.at(15,4))
const puerta2 = new Puerta(estaCerrada = false, position = game.at(0,4))
const puertaFinal = new Puerta(estaCerrada = false, position = game.at(8,1))

// Puerta para el jefe final
object puerta3 inherits Puerta(estaCerrada = true, position = game.at(8,7)) {
    override method cambiarCelda() {
        if (self.estaCerrada().not()) {
            super()
        }
    }

    method accion() {
        estaCerrada = false
    }
}

// Habitaciones
const h1 = new Habitacion(
    puertasDisponibles = [puerta1],
    itemsDisponibles = [hamburgesa, espada, llave],
    enemigosDisponibles = [enemigo1]
)

const h2 = new Habitacion(
    puertasDisponibles = [puerta2, puerta3],
    itemsDisponibles = [cofre],
    enemigosDisponibles = [enemigo2]
)

const h3 = new Habitacion(
    puertasDisponibles = [puertaFinal],
    itemsDisponibles = [],
    enemigosDisponibles = [jefe]
)
