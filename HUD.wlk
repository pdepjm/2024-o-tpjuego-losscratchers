object inventarioHUD {
  const property image = "franja_inventario.png"
  const property position = game.origin()
  const property inventario = []

  method tomar(item) {
    if (inventario.size() < 3) {
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

class EstadoVidas {
  const property imagen
  const maximo
  method vidaEnRango(vida) = vida > maximo 
}

const vidaFull = new EstadoVidas(imagen = "vida_full.png", maximo = 80)
const vidaCuatroQuintos = new EstadoVidas(imagen = "vida_4quintos.png", maximo = 60)
const vidaTresQuintos = new EstadoVidas(imagen = "vida_3quintos.png", maximo = 40)
const vidaDosQuintos = new EstadoVidas(imagen = "vida_2quintos.png", maximo = 20)
const vidaUnQuinto = new EstadoVidas(imagen = "vida_1quinto.png", maximo = 0)
object vidaEmpty inherits EstadoVidas (imagen = "vida_empty.png", maximo = 0){
  override method vidaEnRango(vida) = vida <= maximo
}

object vidaHUD {
  var property image = "vida_full.png"
  const property position = game.origin()
  const estadosDisponibles = [vidaFull, vidaCuatroQuintos, vidaTresQuintos, vidaDosQuintos, vidaUnQuinto, vidaEmpty] 
  method actualizarVida(entidad){
    self.image(estadosDisponibles.find{estado => estado.vidaEnRango(entidad.vida())}.imagen())
  }
}
