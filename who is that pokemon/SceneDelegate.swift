//
//  SceneDelegate.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        //guardarArchivo()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        //guardarArchivo()
    }
    
    //Guarda archivo persistente plist
    func guardarArchivo() {
        // Obtiene la instancia compartida de Datos
        let datos = Datos.sharedDatos()
        
        // Obtiene la ruta del directorio de documentos y concatena el nombre del archivo plist
        let documentosPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let ruta = documentosPath + "/Conf.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)

        // Convierte la lista de jugadores a un array de diccionarios
        let arrayJugadores = datos.jugadores.map { jugador in
            return ["nombre": jugador.nombre, "puntuacion": jugador.puntuacion]
        }

        do {
            // Convierte el array de diccionarios a formato de datos plist (.xml)
            let archivo = try PropertyListSerialization.data(fromPropertyList: arrayJugadores, format: .xml, options: 0)
            
            // Escribe los datos en el archivo en la ruta especificada
            try archivo.write(to: urlArchivo)
        } catch {
            // Maneja errores en caso de que algo salga mal al escribir el archivo
            print("Algo salió mal al escribir el archivo: \(error.localizedDescription)")
        }
    }





}

