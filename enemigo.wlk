/*
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
*/

class Enemigo {
  var property image
  var position = game.at(x_inicial, y_inicial)
  const agarrable = false
  var property vida
  var property danio
  const x_inicial
  const y_inicial
  var property puedoAtacar = true
  method position() = position
  method danio() = danio

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(alf) {
    if (puedoAtacar) { 
      alf.recibirDanio(self) 
      puedoAtacar = false
      game.schedule(3000, {self.puedoAtacar(true)})
    }
  }

  // ENEMIGO
  var count = 0
  var flag_1 = 0
  var flag_2 = 1
  var flag_3 = 1
  var flag_4 = 1

  method movete(ancho, alto) { 
    // 3,3 4x2
    // 7,5
    var p_x = position.x()
    var p_y = position.y()

    if ( flag_1 == 0 )
    {
        count += 1
        position = game.at(p_x + 1, p_y)
        if(count == ancho) { 
          flag_1 = 1 
          flag_2 = 0
          count = 0
         }
    } 
    else if ( flag_2 == 0 )
    {
        count += 1
        position = game.at(p_x, p_y + 1)
        if(count == alto) { 
          flag_2 = 1 
          flag_3 = 0
          count = ancho
         }
    } 
    else if ( flag_3 == 0 )
    {
        count -= 1
        position = game.at(p_x - 1, p_y)
        if(count == 0) { 
          flag_3 = 1 
          flag_4 = 0
          count = alto
         }
    } 
    else if ( flag_4 == 0 )
    {
        count -= 1
        position = game.at(p_x, p_y - 1)
        if(count == 0) { 
          flag_4 = 1 
          flag_1 = 0
         }
    } 

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