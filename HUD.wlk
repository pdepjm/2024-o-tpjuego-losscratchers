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
}