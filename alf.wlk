import items.*
import HUD.*

object alf {
  var property vida = 100
  var property position = game.origin()
  var property image = "placeholder.png"
  var property danio = 20
  //var property armaActual = espada
  //var property danio = armaActual.danio()
  
  method position() = position

  method curarse(curacion) {
    vida = (vida + curacion).min(100)
  }
  
  method danio(danioExtra) {
    danio += danioExtra
  }

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(enemigo) 
  {
    var e_x = enemigo.position().x()
    var e_y = enemigo.position().y()
    var a_x = position.x()
    var a_y = position.y()
    var dif_x = e_x - a_x
    var dif_y = e_y - a_y
    
    if(dif_x < 0) {dif_x *= -1}
    if(dif_y < 0) {dif_y *= -1}
  /*
    if (  dif_x+dif_y == 1 || (dif_x == 1 && dif_y == 1) ) 
    { 
        enemigo.recibirDanio(self)
        game.say(self,"Japish ")
    }
  */    
    if ( enemigo.position().distance(self.position()) == 1 ) 
    { 
        enemigo.recibirDanio(self)
        game.say(self,"Japish ")
    }
  }

  method recibirDanio(enemigo) {
    vida -= enemigo.danio()
    self.morir()
  }

  method morir() {
    if(vida <= 0){
      game.removeVisual(self)
    }
  }

  // hamburgesa = +50 de vida
  // llave = abre puerta/cofre
  // espada = arma en mano

  method utilizar(pos) { 
    const item = inventarioHUD.inventario.get(pos)
    item.accion()
    inventarioHUD.inventario.remove(item)
    game.removeVisual(item)
  }
  
  method agarrar(item) {
    if (inventarioHUD.inventario.size() < 3 && item.esAgarrable()) {
      inventarioHUD.inventario.add(item)
      inventarioHUD.irInventario(item)
    }
  }
}