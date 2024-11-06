import items.*
import alf.*
import enemigo.*
import HUD.*

class Puerta {
    var property image = "puerta-ancha.png"
    const property position
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

    method generarHabitacion() {
        self.generarItems()
        self.generarEnemigos()
        self.generarPuertas()
        game.ground("celda.png") // Fondo
    }

    // method puertaConectada(listaPuertasOrigen, listaPuertasDestino) = listaPuertasOrigen.puertasDisponibles().find { puertaDestino => (puertaOrigen.position().x() == puertaDestino.position().x()) or (puertaOrigen.position().y() == puertaDestino.position().y())}
}


// Puertas
const puerta1 = new Puerta(position = game.at(15,4))
const puerta2 = new Puerta(position = game.at(0,4))

// Habitaciones
const h1 = new Habitacion(
    puertasDisponibles = [puerta1],
    itemsDisponibles = [hamburgesa, espada, llave],
    enemigosDisponibles = [enemigo1]
)

const h2 = new Habitacion(
    puertasDisponibles = [puerta2],
    itemsDisponibles = [cofre],
    enemigosDisponibles = []
)