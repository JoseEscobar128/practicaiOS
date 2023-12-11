//
//  RegistroViewController.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 09/12/23.
//

import UIKit


class RegistroViewController: UIViewController {

    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    let datos = Datos.sharedDatos()
    var name:String = ""
    var finalScore:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblScore.text = "\(finalScore)"
        
    }
    
    @IBAction func playAgain(_ sender: Any) {
        guardarArchivo()

        // Obtén la instancia de MenuViewController del storyboard
        if let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController {
            // Reinicia la configuración antes de realizar la transición
            menuViewController.playBackgroundMusic()

            // Realiza la transición a MenuViewController
            self.navigationController?.pushViewController(menuViewController, animated: true)
        }
    }
    

    
    func guardarArchivo() {
        let datos = Datos.sharedDatos()
        let documentosPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let ruta = documentosPath + "/Conf.plist"
        let urlArchivo = URL(fileURLWithPath: ruta)
        
        let nombre = txtName.text ?? ""
        let puntuacion = finalScore

        // Llama a la función agregarJugador para actualizar o agregar el nuevo jugador
        datos.agregarJugador(nombre: nombre, puntuacion: puntuacion)

        // Convertir la lista de jugadores a un array de diccionarios
        let arrayJugadores = datos.jugadores.map { jugador in
            return ["nombre": jugador.nombre, "puntuacion": jugador.puntuacion]
        }

        do {
            let archivo = try PropertyListSerialization.data(fromPropertyList: arrayJugadores, format: .xml, options: 0)
            try archivo.write(to: urlArchivo)
        } catch {
            print("Algo salió mal al escribir el archivo: \(error.localizedDescription)")
        }
    }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


