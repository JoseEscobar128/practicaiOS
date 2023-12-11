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
    
    //Abre el archivo persistente plist
    func abrirArchivo() {
        let datos = Datos.sharedDatos()
        let ruta = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/Conf.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        print(ruta)

        do {
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
            print("Algo salió mal =(")
        }
    }



}

