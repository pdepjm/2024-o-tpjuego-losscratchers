import wollok.game.*

import alf.*

class Enemigo {
  var property image
  const agarrable = false
  var property vida
  var property danio
  const x_inicial
  const y_inicial
  const movete_x
  const movete_y
  var position = game.at(x_inicial, y_inicial)
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

  method movete() { 
    // 3,3 4x2
    // 7,5
    var p_x = position.x()
    var p_y = position.y()

    if ( flag_1 == 0 )
    {
        count += 1
        position = game.at(p_x + 1, p_y)
        if(count == movete_x) { 
          flag_1 = 1 
          flag_2 = 0
          count = 0
         }
    } 
    else if ( flag_2 == 0 )
    {
        count += 1
        position = game.at(p_x, p_y + 1)
        if(count == movete_y) { 
          flag_2 = 1 
          flag_3 = 0
          count = movete_x
         }
    } 
    else if ( flag_3 == 0 )
    {
        count -= 1
        position = game.at(p_x - 1, p_y)
        if(count == 0) { 
          flag_3 = 1 
          flag_4 = 0
          count = movete_y
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
      alf.habitacionActual().enemigosDisponibles().remove(self)
    }
  }
}

// Crear instancias
const enemigo1 = new Enemigo(image = "placeholder_attack.png", vida = 100, danio = 20, x_inicial = 5, y_inicial = 3, movete_x = 3, movete_y = 3)
const enemigo2 = new Enemigo(image = "placeholder_attack.png", vida = 100, danio = 20, x_inicial = 5, y_inicial = 4, movete_x = 2, movete_y = 2)
const jefe = new Enemigo(image = "placeholder_attack.png", vida = 500, danio = 50, x_inicial = 3, y_inicial = 3, movete_x = 4, movete_y = 2)
const enemigos = [enemigo1, enemigo2, jefe]