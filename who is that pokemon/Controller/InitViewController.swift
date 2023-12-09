//
//  InitViewController.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 05/12/23.
//

import UIKit

class InitViewController: UIViewController {

    @IBOutlet weak var imvPokemon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let w = view.frame.width * 0.9
        let h = w * 0.4318
        let x = (view.frame.width - w)/2.0
        let y = -h
        
        imvPokemon.frame = CGRect(x: x, y: y, width: w, height: h)
        imvPokemon.alpha = 0.0
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animate(withDuration: 2) {
            self.imvPokemon.frame = CGRect(x: self.imvPokemon.frame.origin.x, y: (self.view.frame.height - self.imvPokemon.frame.height)/2.0, width: self.imvPokemon.frame.width, height: self.imvPokemon.frame.height)
            self.imvPokemon.alpha = 1.0
        } completion: { res in
            self.performSegue(withIdentifier: "sgSplash", sender: nil)
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

}
