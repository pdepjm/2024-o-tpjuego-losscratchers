import main.posicionAleatoria

object espada {
  var property esAgarrable = true
  var property danio = 100
  var property image = "espada.jpg"
  var property position = posicionAleatoria.calcular()
  method irInventario(x, y) {position = game.at(x, y)}
}

object llave {
  var property esAgarrable = true
  var property danio = 100
  var property image = "llave.jpg"
  var property position = posicionAleatoria.calcular()
  method irInventario(x, y) {position = game.at(x, y)}
}

object hamburgesa {
  var property esAgarrable = true
  var property curacion = 50
  var property image = "hamburguesa.jpg"
  var property position = posicionAleatoria.calcular()
  method irInventario(x, y) {position = game.at(x, y)}
}