//
//  Datos.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 06/12/23.
//

import UIKit

class Datos: NSObject {
    var jugadores: [(nombre: String, puntuacion: Int)] = []
    static var singleton: Datos!
    
    override init() {
        super.init()
        
        // Inicializar con algunos datos de ejemplo
        jugadores = [("Jugador1", 100), ("Jugador2", 150), ("Jugador3", 200), ("Jugador4", 50), ("Jugador5", 300)]
    }
    
    static func sharedDatos() -> Datos {
        if singleton == nil {
            singleton = Datos.init()
        }
        
        return singleton
    }
}

