import HUD.*
import wollok.game.*
import main.*
import alf.*
import finalDelJuego.*

object animador{
  method mostrarHerida(entidad, imagenOriginal, animacionDanio) {
    entidad.image(animacionDanio)
    game.schedule(650, {entidad.image(imagenOriginal)})
  }
}

class Enemigo {
  var property image
  const property imageDmg 
  var property vida
  var property danio
  const property x_inicial
  const property y_inicial
  var property position = game.at(x_inicial, y_inicial)
  var property puedoAtacar = true
  const movimiento

  // Revisar metodos de atacar y recibirDanio tanto en Alf como en los enemigos
  method atacar(alf) {
    if (puedoAtacar) { 
      alf.recibirDanio(self) 
      puedoAtacar = false
      game.schedule(3000, {self.puedoAtacar(true)})
    }
  }

  // ENEMIGO
  method movete() {
    movimiento.actualizarPosicion(self)
  }

  method recibirDanio(alf) {
    vida -= alf.danio()
    animador.mostrarHerida(self, self.image(), self.imageDmg())
    self.morir()
  }

  method morir() {
    if(vida <= 0){
      game.removeVisual(self)
      self.puedoAtacar(false)
      alf.habitacionActual().enemigosDisponibles().remove(self)
      alf.habitacionActual().refrescarEnemigos()
    }
  }
}

class Trayectos {
  const movete_x
  const movete_y

  var count = 0
  var flag_1 = 0
  var flag_2 = 1
  var flag_3 = 1
  var flag_4 = 1

  method actualizarPosicion(entidad) { 
    const p_x = entidad.position().x()
    const p_y = entidad.position().y()

    if ( flag_1 == 0 ){
      count += 1
      entidad.position(game.at(p_x + 1, p_y))
      if(count == movete_x) { 
        flag_1 = 1 
        flag_2 = 0
        count = 0
      }
    } 
    else if ( flag_2 == 0 ){
      count += 1
      entidad.position(game.at(p_x, p_y + 1))
      if(count == movete_y) { 
        flag_2 = 1 
        flag_3 = 0
        count = movete_x
      }
    } 
    else if ( flag_3 == 0 ){
      count -= 1
      entidad.position(game.at(p_x - 1, p_y))
      if(count == 0) { 
        flag_3 = 1 
        flag_4 = 0
        count = movete_y
      }
    } 
    else if ( flag_4 == 0 ){
      count -= 1
      entidad.position(game.at(p_x, p_y - 1))
      if(count == 0) { 
        flag_4 = 1 
        flag_1 = 0
      }
    } 
  }
}

// Tipos de trayectos
const cuadradoChico = new Trayectos(movete_x = 2, movete_y = 2)
const cuadradoGrande = new Trayectos(movete_x = 3, movete_y = 3)
const lineaHorizontal = new Trayectos(movete_x = 3, movete_y = 1)
const lineaVertical = new Trayectos(movete_x = 1, movete_y = 3)

// Crear instancias
const enemigo1 = new Enemigo(image = "goblin_-_left.png", imageDmg = "goblin_-_left_dmg.gif", vida = 100, danio = 20, x_inicial = 5, y_inicial = 3, movimiento = lineaVertical)
const enemigo2 = new Enemigo(image = "goblin_-_left.png", imageDmg = "goblin_-_left_dmg.gif", vida = 100, danio = 20, x_inicial = 5, y_inicial = 4, movimiento = cuadradoChico)
const enemigo3 = new Enemigo(image = "goblin_-_right.png", imageDmg = "goblin_-_right_dmg.gif", vida = 100, danio = 20, x_inicial = 11, y_inicial = 3, movimiento = lineaVertical)
const enemigo4 = new Enemigo(image = "goblin_-_left.png", imageDmg = "goblin_-_left_dmg.gif", vida = 100, danio = 20, x_inicial = 5, y_inicial = 4, movimiento = cuadradoChico)

object jefe inherits Enemigo(image = "Jefe.png", imageDmg = "Jefe_dmg.gif",vida = 500, danio = 50, x_inicial = 8, y_inicial = 3, movimiento = cuadradoGrande) {
  override method morir() {
    if(vida <= 0) {
      // Termina el juego
      final.victoria()
    }
  }
  override method recibirDanio(alf) {
    vida -= alf.danio()
    animador.mostrarHerida(self, self.image(), self.imageDmg())
    self.morir()
  }
}