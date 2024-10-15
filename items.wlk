import main.posicionAleatoria

import alf.*

object espada {
  var property esAgarrable = true
  var property danioExtra = 20
  var property image = "espada.png"
  var property position = posicionAleatoria.calcular()
  method irInventario(x, y) {position = game.at(x, y)}
  
  method accion() {
    alf.danio(danioExtra)
  }
}

object llave {
  var property esAgarrable = true
  var property image = "llave.png"
  var property position = posicionAleatoria.calcular()
  method irInventario(x, y) {position = game.at(x, y)}
  method accion() {
    //alf.vida(curacion)
  }
}

object hamburgesa {
  var property esAgarrable = true
  var property curacion = 50
  var property image = "hamburguesa.png"
  var property position = posicionAleatoria.calcular()
  method irInventario(x, y) {position = game.at(x, y)}

  method accion() {
    alf.curarse(curacion)
  }
}