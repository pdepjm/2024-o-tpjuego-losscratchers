import HUD.*
import main.posicionAleatoria

import alf.*

/*
object llave {
  var property agarrable = true
  var property image = "llave.png"
  var property position = posicionAleatoria.calcular()
  method accion() {
    cofre.accion()
  }
}

object espada {
  var property esAgarrable = true
  var property danioExtra = 20
  var property image = "espada.png"
  var property position = posicionAleatoria.calcular()
  
  method accion() {
    alf.danio(danioExtra)
  }
}

object hamburgesa {
  var property esAgarrable = true
  var property curacion = 50
  var property image = "hamburguesa.png"
  var property position = posicionAleatoria.calcular()

  method accion() {
    alf.curarse(curacion)
  }
}

object cofre {
  var property esAgarrable = false
  var property image = "cofre.png"
  var property position = game.at(14,6)

  method accion() {
    game.removeVisual(self)
  }
}
*/

class Item {
  const property image
  const property agarrable = true
  var property position = posicionAleatoria.calcular()
  method accion()
}

class ItemOfensivo inherits Item {
  const property danioExtra
  override method accion() {
    alf.danio(danioExtra)
  }
}

class ItemDeCuracion inherits Item {
  const property curacion
  override method accion() {
    alf.curarse(curacion)
  }
}

class ItemDeApertura inherits Item {
  override method accion() {
    cofre.accion()
  }
}

class ItemDeAlmacenamiento inherits Item (agarrable = false) {
  override method accion() {
    if(alf.position().distance(self.position()) == 1){
      const hamburgesaMAX = new ItemDeCuracion(image = "foto_test.jpg", curacion = 80, position = self.position())
      game.addVisual(hamburgesaMAX)
      game.removeVisual(self)
    }
    
  }
}

const espada = new ItemOfensivo(image = "espada.png", danioExtra = 20)
const hamburgesa = new ItemDeCuracion(image = "hamburguesa.png", curacion = 50)
const cofre = new ItemDeAlmacenamiento(image = "cofre.png", position = game.at(14,6))
const llave = new ItemDeApertura(image = "llave.png")