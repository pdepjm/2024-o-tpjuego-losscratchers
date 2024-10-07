object alf {
  var property vida = 100
  var property position = game.origin()
  var property image = "placeholder.png"

  //var property armaActual = espada
  //var property danio = armaActual.danio()
  const inventario = []
  
  method position() = position

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(enemigo) = enemigo.recibirDanio(self) 

  method recibirDanio(enemigo) {
    vida -= enemigo.danio()
    self.morir()
  }

  method morir() {
    if(vida <= 0){
      game.removeVisual(self)
    }
  }

  method utilizar(item) {
    
  }
  
  method agarrar(item) {
    if (inventario.size() < 3 && item.esAgarrable() )
    {
      game.removeVisual(item)
      inventario.add(item)
    }
  }
  
  method mostrarInventarioTemp(){
    game.say(self,inventario.size().toString())
  }

  

}
