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
    
    /*func agregarJugador(nombre: String, puntuacion: Int) {
            // Busca si ya existe un jugador con el mismo nombre
            if let index = jugadores.firstIndex(where: { $0.nombre == nombre }) {
                // Si existe, actualiza la puntuación
                jugadores[index].puntuacion = puntuacion
            } else {
                // Si no existe, agrega un nuevo jugador
                jugadores.append((nombre: nombre, puntuacion: puntuacion))
            }
        }*/
    
    func agregarJugador(nombre: String, puntuacion: Int) {
        // Busca el índice del primer jugador con una puntuación igual o menor
        if let index = jugadores.firstIndex(where: { $0.puntuacion <= puntuacion }) {
            // Si existe y la nueva puntuación es igual o mayor, actualiza la puntuación y el nombre
            if puntuacion >= jugadores[index].puntuacion {
                var jugadorActualizado = jugadores[index]
                jugadorActualizado.puntuacion = puntuacion
                jugadorActualizado.nombre = nombre

                // Elimina el jugador existente
                jugadores.remove(at: index)

                // Vuelve a insertar el jugador actualizado en la posición correcta
                let newIndex = jugadores.firstIndex { $0.puntuacion > puntuacion } ?? jugadores.count
                jugadores.insert(jugadorActualizado, at: newIndex)
            }
        } else {
            // Si no existe, agrega un nuevo jugador
            jugadores.append((nombre: nombre, puntuacion: puntuacion))
        }
    }







}

