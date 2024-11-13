import items.*
import HUD.*
import mapa.*
import finalDelJuego.*

object alf {
  var property vida = 100
  var property position = game.at(1,2)
  var property image = "alf.png"
  var property danio = 20
  var property habitacionActual = h1 // Empieza en h1
  
  method position() = position

  method curarse(curacion) {
    vida = (vida + curacion).min(100)
    vidaHUD.actualizarVida(self)
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
    vidaHUD.actualizarVida(self)
    self.morir()
  }

  method morir() {
    if(vida <= 0) {
      final.derrota()
    }
  }

  method utilizar(pos) { 
    inventarioHUD.usar(pos)
    inventarioHUD.moverItems()
  }
  
  method agarrar(item) {
    item.irAlInventario()
  }

  method reiniciarImagen() {
    game.removeVisual(self)
    game.addVisual(self)
  }

  /*
  method iniciar(){
    keyboard.z().onPressDo({ self.atacar(enemigoActual)})
  }
  */
}
