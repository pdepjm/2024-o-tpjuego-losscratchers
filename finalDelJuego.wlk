object fondoVictoria {
    var property image = "victoria.jpeg"
    var property position = game.at(0,0)
}

object fondoDerrota {
    var property image = "derrota.jpeg"
    var property position = game.at(0,0)
}

object final {
    method victoria() {
        game.clear()
        game.addVisual(fondoVictoria)
    }

    method derrota() {
        game.clear()
        game.addVisual(fondoDerrota)
    }
}