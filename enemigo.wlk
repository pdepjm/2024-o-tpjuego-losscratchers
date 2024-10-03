class Enemigo {
  var property vida = 100
  const position = new MutablePosition(x=0, y=0)
  var property danio = 20
  var property image = "placeholder.png"

  method position() = position

  method danio() = danio

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(alf) = alf.recibirDanio(self) 

  method recibirDanio(alf) {
    vida -= alf.danio()
  }
}

const enemigo1 = new Enemigo()