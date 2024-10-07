import main.posicionAleatoria

object enemigoMelee {
  var property esAgarrable = false
  var property vida = 100
  var position = posicionAleatoria.calcular()
  var property danio = 20
  var property image = "placeholder_attack.png"
  var puedoAtacar = true

  method position() = position

  method danio() = danio

  method nuevoAtaque(value) = value 

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(alf) {
    if (puedoAtacar) { 
      alf.recibirDanio(self) 
      puedoAtacar = false
    }
    game.onTick(2000,"",{self.nuevoAtaque(true)})
  }

  method movete() {
    if(0.randomUpTo(game.height()).truncate(0) % 2 == 0 )
    {
      if(self.position().x() < 16){
        position = game.at((self.position().x() + 1),self.position().y())
        }
    } 
    else 
    {
      if(self.position().y() < 8)
      {
          position = game.at(self.position().x(),(self.position().y()+1))
      }
    }
    //position = posicionAleatoria.calcular()
  }

  method recibirDanio(alf) {
    vida -= alf.danio()
  }

  method morir() {
    if(vida <= 0){
      game.removeVisual(self)
    }
  }
}