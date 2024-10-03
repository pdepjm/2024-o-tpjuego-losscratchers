object alf {
  var property vida = 100
  var property position = game.origin()
  var property image = "placeholder.png"

  var property armaActual = espada
  var property danio = armaActual.danio()
  
  method position() = position

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(enemigo) = enemigo.recibirDanio(self) 

  method recibirDanio(enemigo) {
    vida -= enemigo.danio()
  }
}

// Espada base --> podemos pensar en diferentes tipos de espadas u otras armas con diferentes daños
object espada {
  var property danio = 20
}
