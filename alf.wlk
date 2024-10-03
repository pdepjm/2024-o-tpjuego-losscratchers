object alf {
  var property vida = 100
  const position = new MutablePosition(x=0, y=0)
  var property image = "alf-pixelart.jpg"

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