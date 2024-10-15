import main.posicionAleatoria

class EnemigoCoolDown {
  const idTick
  var puedeAtacar = false
  
  method configurarTick() {
    game.onTick(2000, "Cooldown" + idTick, {self.habilitarAtaque()})
  }

  method habilitarAtaque() {
    puedeAtacar = true
  }

  method atacar(unPersonaje) {
    if(puedeAtacar) {
       unPersonaje.recibirDanio()
       puedeAtacar = false
    }
  }

  // Demás implementaciones
}

class GeneradorDeEnemigosConCoolDown {
  // Atributos locos 

  method crearEnemigo() {
    const enemigoNuevo = new EnemigoCoolDown(idTick = 1)
    enemigoNuevo.configurarTick()
    enemigoNuevo.agregarColisiones()
    game.addVisual(enemigoNuevo)
  }

  // Demás implementaciones
}

object enemigoMelee {
  const esAgarrable = false
  var property vida = 100
  var position = posicionAleatoria.calcular()
  var property danio = 20
  var property image = "placeholder_attack.png"
  var property puedoAtacar = false

  method position() = position

  method danio() = danio

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(alf) {
    if (puedoAtacar) { 
      alf.recibirDanio(self) 
      puedoAtacar = false
    }
  }

  method movete(recorrido, pos_actual) 
  { 
    position = game.at(recorrido.get(pos_actual).get(0),recorrido.get(pos_actual).get(1))
    
    /*
    if((1..4).anyOne().equals(1)){
      position = self.position().right(1)
    } else if((1..4).anyOne().equals(2)) {
      position = self.position().up(1)
    } else if((1..4).anyOne().equals(3)) {
      position = self.position().left(1).
    } else {
      position = self.position().down(1)
    }
    
    var x = self.position().x()
    var y = self.position().y()
    var limit_x = game.width()
    var limit_y = game.height()

    if(x >= limit_x)
    {
      position = self.position().at(limit_x - 1, y)
    } 
    else if(x < game.origin().x()) 
    {
      position = self.position().at(game.origin().x(), y)
    }  
    else if(y >= game.height())
    {
      position = self.position().at(x, limit_y - 1)
    } 
    else if(y < game.origin().y()) 
    {
      position = self.position().at(x, limit_y)
    }*/


  }

  method recibirDanio(alf) {
    vida -= alf.danio()
    self.morir()
  }

  method morir() {
    if(vida <= 0){
      game.removeVisual(self)
    }
  }
}