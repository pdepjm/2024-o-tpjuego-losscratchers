object inventarioHUD {
  const property image = "franja_inventario.png"
  const property position = game.origin()
  const inventario = []

  method tomar(item) {
    if (inventario.size() < 3 && item.agarrable()) {
      inventario.add(item)
      item.position(game.at(12 + inventario.size(), 0))
    }
  }

  method usar(pos){
    const item = inventario.get(pos)
    item.accion()
    inventario.remove(item)
    game.removeVisual(item)
  }
  
  method moverItems() {
    var i = 1
    inventario.forEach({ item => 
      item.position(game.at(12 + i, 0))
      i += 1
    })
  }
}

object vidaHUD {
  var property image = "vida_full.png"
  const property position = game.origin()
  method actualizarVida(entidad){
        if (entidad.vida() > 80)
        {
          self.image("vida_full.png")
        } 
        else if(entidad.vida() > 60 )
        {
          self.image("vida_4quintos.png")
        } 
        else if(entidad.vida() > 40) {
          self.image("vida_3quintos.png")
        } 
        else if(entidad.vida() > 20) {
          self.image("vida_2quintos.png")
        } 
        else if(entidad.vida() > 0){
          self.image("vida_1quinto.png")
        } 
  }
}
