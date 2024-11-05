import items.*
import enemigo.*
import HUD.*

class Puerta {
    const property position
    const property habitacionOrigen
    const property habitacionDestino

    method cambiarCelda() {
        // Elimina las puertas, y todos los items y enemigos que quedaron restando en la celda
        habitacionOrigen.puertasDisponibles().forEach { puerta => game.removeVisual(puerta) }
        habitacionOrigen.itemsDisponibles().forEach { item => game.removeVisual(item) }
        habitacionOrigen.enemigosDisponibles().forEach{ enemigo => game.removeVisual(enemigo) }
        
        // Generamos las puertas, items y enemigos para que aparezcan en la nueva celda
        habitacionDestino.generarPuertas()
        habitacionDestino.generarEnemigos()
        habitacionDestino.generarItems()
    }
}

class Habitacion {
    // Usar remove items cuando se utilizan y enemigos cuando se mueren
    const property puertasDisponibles = []
    const property itemsDisponibles = []
    const property enemigosDisponibles = []
    
    method generarPuertas() {
        puertasDisponibles.forEach { puerta => game.addVisual(puerta) }
        //game.boardGround("C1.jpg")
    }

    method generarItems() {
        itemsDisponibles.forEach { item => game.addVisual(item) }
    }
    
    method generarEnemigos() {
        enemigosDisponibles.forEach{ enemigo => game.addVisual(enemigo) }
    }

    //method puertaConectada(listaPuertasOrigen, listaPuertasDestino) = listaPuertasOrigen.puertasDisponibles().find { puertaDestino => (puertaOrigen.position().x() == puertaDestino.position().x()) or (puertaOrigen.position().y() == puertaDestino.position().y())}
}

// puertas  = [new Puerta(position,habitacionDestino=c2)
// game.whenCollideDo( alf, { puerta => 
/*        alf.position(game.at(puerta.habitacionDestino.position()))
          puerta.cambiarCelda(puerta.position)
    })


*/
const H1 = new Habitacion(
    puertasDisponibles = [new Puerta(position = game.at(4,8), habitacionOrigen = H1, habitacionDestino = H2)],
    itemsDisponibles = [new ItemDeCuracion(image = "hamburguesa.png", curacion = 50), new ItemDeCuracion(image = "hamburguesa.png", curacion = 50, position = game.at(4,4))],
    enemigosDisponibles = [new Enemigo(image = "placeholder_attack.png", vida = 100, danio = 20, x_inicial = 5, y_inicial = 5)]
)

const H2 = new Habitacion(
    puertasDisponibles = [new Puerta(position = game.at(4,1), habitacionOrigen = H2, habitacionDestino = H1)],
    itemsDisponibles = [new ItemOfensivo(image = "espada.png", danioExtra = 50)],
    enemigosDisponibles = [new Enemigo(image = "placeholder_attack.png", vida = 100, danio = 20, x_inicial = 5, y_inicial = 6)]
)
   
/*
new Puerta(position = game.at(1,1), habitacionOrigen = C1, habitacionDestino = C2)
main... 
C1.generarItems()

*/