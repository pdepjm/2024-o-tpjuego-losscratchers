import HUD.*
import main.posicionAleatoria
import mapa.*

import alf.*

class Item {
  const property image
  var property position = posicionAleatoria.calcular()
  method accion()
  method irAlInventario(){
    inventarioHUD.tomar(self)
  }
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
  const abreA
  override method accion() {
    abreA.accion()
  }
}

class ItemDeAlmacenamiento inherits Item () {
  override method accion() {
    if(alf.position().distance(self.position()) == 1) {
      alf.habitacionActual().itemsDisponibles().remove(self)
      alf.habitacionActual().itemsDisponibles().add(llaveJefe)
      game.addVisual(llaveJefe)
      game.removeVisual(self)
    }
  }
  override method irAlInventario() {}
}

const espada = new ItemOfensivo(image = "espada.png", danioExtra = 20, position = game.at(11,6))
const hamburgesa = new ItemDeCuracion(image = "hamburguesa.png", curacion = 50, position = game.at(12,6))
const cofre = new ItemDeAlmacenamiento(image = "cofre.png", position = game.at(14,6))
const llave = new ItemDeApertura(abreA = cofre, image = "llave.png", position = game.at(13,6))
const llaveJefe = new ItemDeApertura(abreA = puerta3, image = "llaveJefe.png", position = cofre.position())