//
//  AppDelegate.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 06/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Llama a la función para abrir el archivo persistente al iniciar la aplicación
        abrirArchivo()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // Abre el archivo persistente
    // Abre el archivo persistente
    // Abre el archivo persistente
    func abrirArchivo() {
        let datos = Datos.sharedDatos()
        // Obtiene la ruta del directorio de documentos y concatena el nombre del archivo plist
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Conf.plist"

        let fileManager = FileManager.default

        // Verifica si la ruta del archivo existe
        if fileManager.fileExists(atPath: ruta) {
            // La ruta existe, puedes continuar abriendo el archivo
            print("La ruta del archivo existe: \(ruta)")

            // Crea una URL con la ruta del archivo
            let urlArchivo = URL(fileURLWithPath: ruta)
            

            do {
                // Resto del código para leer el archivo...
                let archivo = try Data(contentsOf: urlArchivo)

                if let diccionario = try PropertyListSerialization.propertyList(from: archivo, options: [], format: nil) as? [String: Any] {
                    // Si el contenido es un diccionario, asume que es la antigua estructura y actualiza la lista de jugadores
                    if let nombre = diccionario["nombre"] as? String, let puntuacion = diccionario["puntuacion"] as? Int {
                        datos.jugadores = [(nombre: nombre, puntuacion: puntuacion)]
                    }
                } else if let arrayJugadores = try PropertyListSerialization.propertyList(from: archivo, options: [], format: nil) as? [[String: Any]] {
                    // Si el contenido es un array, actualiza la lista de jugadores
                    datos.jugadores = arrayJugadores.compactMap { jugadorDict in
                        guard let nombre = jugadorDict["nombre"] as? String,
                              let puntuacion = jugadorDict["puntuacion"] as? Int else {
                            return nil
                        }
                        return (nombre: nombre, puntuacion: puntuacion)
                    }
                } else {
                    print("Contenido de archivo inesperado.")
                }

            } catch {
                print("Error al leer el archivo: \(error)")
            }
        } else {
            // La ruta no existe, crea el archivo y agrega datos predeterminados
            print("La ruta del archivo no existe: \(ruta)")

            // Puedes personalizar esta lógica según tus necesidades
            let diccionarioInicial = ["jugadores": [["nombre": "Jugador1", "puntuacion": 1],
                                                   ["nombre": "Jugador2", "puntuacion": 1],
                                                   ["nombre": "Jugador3", "puntuacion": 1],
                                                   ["nombre": "Jugador4", "puntuacion": 1],
                                                   ["nombre": "Jugador5", "puntuacion": 1]]]

            do {
                let archivo = try PropertyListSerialization.data(fromPropertyList: diccionarioInicial, format: .xml, options: 0)
                try archivo.write(to: URL(fileURLWithPath: ruta))
                print("Archivo creado con éxito.")

                // Actualiza la lista de jugadores con los datos iniciales
                if let arrayJugadores = diccionarioInicial["jugadores"] {
                    datos.jugadores = arrayJugadores.compactMap { jugadorDict in
                        guard let nombre = jugadorDict["nombre"] as? String,
                              let puntuacion = jugadorDict["puntuacion"] as? Int else {
                            return nil
                        }
                        return (nombre: nombre, puntuacion: puntuacion)
                    }
                }
            } catch {
                print("Error al crear el archivo: \(error)")
            }
        }
    }


}

