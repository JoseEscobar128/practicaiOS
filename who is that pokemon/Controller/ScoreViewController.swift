//
//  ScoreViewController.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 06/12/23.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var txtScore: UITextView!
    let datos = Datos.sharedDatos()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ordena la lista de jugadores de mayor a menor puntuación
                let jugadoresOrdenados = datos.jugadores.sorted { $0.puntuacion > $1.puntuacion }

                // Construir una cadena con la lista de nombres y puntuaciones
                var scoreText = ""

                for jugador in jugadoresOrdenados {
                    scoreText += "\(jugador.nombre):\t \(jugador.puntuacion)\n"
                    print("Nombre: \(jugador.nombre), Puntuación: \(jugador.puntuacion)")
                }

                // Establecer el texto del label con la lista de nombres y puntuaciones
                txtScore.text = scoreText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
