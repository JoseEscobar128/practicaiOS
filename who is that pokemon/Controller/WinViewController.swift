//
//  WinViewController.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 06/12/23.
//

import UIKit
import Kingfisher

class WinViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var pokemonLabel: UILabel!
    
    
    
    var pokemonName:String = " "
    var pokemonImageURL:String = " "
    var finalScore:Int = 0
    
    
    
    override func viewDidLoad() {
        
        lblScore.text = "Perdiste, tu puntaje fue de \(finalScore)"
        pokemonLabel .text = "No, es un \(pokemonName)"
        pokemonImage.kf.setImage(with: URL(string: pokemonImageURL))
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegistar(_ sender: UIButton) {
        
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
