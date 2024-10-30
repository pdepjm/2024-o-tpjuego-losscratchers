object inventarioHUD {
  const property image = "inventario.png"
  const property position = game.at(13,0)
  const inventario = []
  method irInventario(item) {item.position(12 + inventario.size(), 0)}
}