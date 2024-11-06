import items.*
import HUD.*

object alf {
  var property vida = 100
  var property position = game.at(0,1)
  var property image = "alf_sprite.png"
  var property danio = 20
  
  method position() = position

  method curarse(curacion) {
    vida = (vida + curacion).min(100)
  }
  
  method danio(danioExtra) {
    danio += danioExtra
  }

  method atacar(enemigo) 
  { 
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

  method utilizar(pos) { 
    inventarioHUD.usar(pos)
    inventarioHUD.moverItems()
  }
  
  method agarrar(item) {
    inventarioHUD.tomar(item)
  }
}