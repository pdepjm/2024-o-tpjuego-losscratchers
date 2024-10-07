import main.posicionAleatoria

object espada {
  var property esAgarrable = true
  var property danio = 100
  var property image = "espada.jpg"
  const position = posicionAleatoria.calcular()
  method position() = position
}

object llave {
  var property esAgarrable = true
  var property danio = 100
  var property image = "llave.jpg"
  const position = posicionAleatoria.calcular()
  method position() = position
}

object hamburgesa {
  var property esAgarrable = true
  var property curacion = 50
  var property image = "hamburguesa.jpg"
  const position = posicionAleatoria.calcular()
  method position() = position
}