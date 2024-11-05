import HUD.*
import main.posicionAleatoria

import alf.*

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
      const hamburgesaMAX = new ItemDeCuracion(image = "golden_apple.wepb", curacion = 80, position = self.position())
      game.addVisual(hamburgesaMAX)
      game.removeVisual(self)
    }
    
  }
}

const espada = new ItemOfensivo(image = "espada.png", danioExtra = 20)
const hamburgesa = new ItemDeCuracion(image = "hamburguesa.png", curacion = 50)
const cofre = new ItemDeAlmacenamiento(image = "cofre.png", position = game.at(14,6))
const llave = new ItemDeApertura(image = "llave.png")