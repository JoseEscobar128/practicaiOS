//
//  MenuViewController.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 05/12/23.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet weak var imgPoke: UIButton!
    
    
    let cancion = "PokemonMP"
    var audioPlayer = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundMusic()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        if audioPlayer.isPlaying
        {
            sender.setImage(UIImage(named: "pause.png"), for: .normal)
            audioPlayer.pause()
            
        }
        else
        {
            sender.setImage(UIImage(named: "play.png"), for: .normal)
            audioPlayer.play()
        }
    }
    
    @IBAction func btnJugar(_ sender: Any) {
        audioPlayer.pause()
        
    }
    
    @IBAction func btnScore(_ sender: Any) {
        
        audioPlayer.pause()
        
    }
    
    func playBackgroundMusic() {
        if let path = Bundle.main.path(forResource: cancion, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer.numberOfLoops = -1 // Repetir indefinidamente
                audioPlayer.play()
            } catch {
                print("Error al reproducir la canción: \(error.localizedDescription)")
            }
        }
    }
}
