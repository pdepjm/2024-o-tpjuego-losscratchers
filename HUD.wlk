object inventarioHUD {
  const property image = "franja_inventario.png"
  const property position = game.at(0,0)
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