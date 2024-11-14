import items.*
import alf.*
import enemigo.*
import HUD.*

class Puerta {
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
        if (habitacionOrigen.enemigosDisponibles().size() == 0) {
            // Elimina las puertas, y todos los items y enemigos que quedaron restando en la celda
            habitacionOrigen.puertasDisponibles().forEach { puerta => game.removeVisual(puerta) }
            habitacionOrigen.itemsDisponibles().forEach { item => game.removeVisual(item) }
            
            // Cambiamos el fondo
            game.removeVisual(habitacionOrigen) // Fondo viejo
            game.addVisual(habitacionDestino) // Fondo nuevo

            // Reinicia imagenes para que no sean tapadas por el fondo
            inventarioHUD.reiniciarImagen()
            
            // Generamos las puertas, items y enemigos para que aparezcan en la nueva celda
            habitacionDestino.generarHabitacion()
            // Reiniciar enemigos
            habitacionDestino.iniciarEnemigos()
            
            // Alf
            alf.reiniciarImagen()

            // Mover a Alf
            alf.position(puertaDestino.position())
            alf.habitacionActual(habitacionDestino)
        }
    }
}

class Habitacion {
    // Usar remove items cuando se utilizan y enemigos cuando se mueren
    const property puertasDisponibles = []
    const property itemsDisponibles = []
    const property enemigosDisponibles = []
    const property image
    const property position = game.at(0,0)
    
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
        self.generarEnemigos()
        self.generarPuertas()
        self.generarItems()
    }

    method iniciarEnemigos() {
        enemigosDisponibles.forEach { enemigoActual => game.whenCollideDo(enemigoActual, {alf => 
            enemigoActual.atacar(alf)
        })}
        enemigosDisponibles.forEach { enemigoActual => game.onTick(1100, "movimiento", {enemigoActual.movete()}) }
        enemigosDisponibles.forEach { enemigoActual => keyboard.z().onPressDo({ alf.atacar(enemigoActual) }) }
    }

    method refrescarEnemigos() {
        enemigosDisponibles.forEach { enemigoActual => game.whenCollideDo(enemigoActual, {alf => 
            enemigoActual.atacar(alf)
        })}
        enemigosDisponibles.forEach { enemigoActual => keyboard.z().onPressDo({ alf.atacar(enemigoActual) }) }
    }

    // method puertaConectada(listaPuertasOrigen, listaPuertasDestino) = listaPuertasOrigen.puertasDisponibles().find { puertaDestino => (puertaOrigen.position().x() == puertaDestino.position().x()) or (puertaOrigen.position().y() == puertaDestino.position().y())}
}

// Puertas
const puerta1 = new Puerta(estaCerrada = false, position = game.at(15,4))
const puerta2 = new Puerta(estaCerrada = false, position = game.at(0,4))
const puerta4 = new Puerta(estaCerrada = false, position = game.at(15,4))
const puerta5 = new Puerta(estaCerrada = false, position = game.at(0,4))
const puerta6 = new Puerta(estaCerrada = false, position = game.at(8,1))
const puerta7 = new Puerta(estaCerrada = false, position = game.at(8,7))
const puertaFinal = new Puerta(estaCerrada = false, position = game.at(8,1))

// Puerta para el jefe final
object puerta3 inherits Puerta(estaCerrada = true, position = game.at(8,7)) {
    var property image = "puertaJefeCerrada.png"
    override method cambiarCelda() {
        if (self.estaCerrada().negate()) {
            super()
        }
    }

    method accion() {
        estaCerrada = false
        self.image("puertaJefeAbierta.png")
    }
}

// Habitaciones
const h1 = new Habitacion(
    puertasDisponibles = [puerta1],
    itemsDisponibles = [hamburgesa, espada],
    enemigosDisponibles = [enemigo1],
    image = "Sala_Inicial.png"
)

const h2 = new Habitacion(
    puertasDisponibles = [puerta2, puerta3, puerta4, puerta6],
    itemsDisponibles = [],
    enemigosDisponibles = [enemigo2, enemigo3],
    image = "Sala_Centro.png"
)

const h4 = new Habitacion(
    puertasDisponibles = [puerta5],
    itemsDisponibles = [cofre],
    enemigosDisponibles = [],
    image = "Sala_Cofre.png"
)

const h5 = new Habitacion(
    puertasDisponibles = [puerta7],
    itemsDisponibles = [llave],
    enemigosDisponibles = [enemigo4],
    image = "Sala_Llave.png"
)

const h3 = new Habitacion(
    puertasDisponibles = [puertaFinal],
    itemsDisponibles = [],
    enemigosDisponibles = [jefe],
    image = "Sala_Jefe.png"
)