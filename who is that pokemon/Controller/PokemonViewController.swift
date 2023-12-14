//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Jose Escobar on 19/11/23.
//

import UIKit
import Kingfisher
import AVFAudio

class PokemonViewController: UIViewController {

    
    @IBOutlet var btnOpciones: [UIButton]!
    @IBOutlet weak var lblRespuesta: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    
    let datos = Datos.sharedDatos()
    lazy var pokemonManager = PokemonMaganer()
    lazy var imageManager = ImageMaganer()
    lazy var game = GameModel()
    
    
    var random4Pokemons: [PokemonModel] = [] {
        didSet{
            setButtonTitles()
        }
    }
    var correctAnswer: String = ""
    var correctAnswerImage: String = ""
    var audioPlayer: AVAudioPlayer?
    var intentosIncorrectos: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        imageManager.delegate = self
        
        print(game.getScore())
        //lblScore.text = "Puntaje: 100"
        
        createButtons()
        pokemonManager.fetchPokeon()
        lblRespuesta.text = " "
        
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        let userAnswer = sender.title(for: .normal)!
        
        if game.checkAnswer(userAnswer, correctAnswer.capitalized){
            lblRespuesta.text = "Si, es un \(userAnswer)"
            lblScore.text = "Puntaje \(game.score)"
            
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2.0
            
            let url = URL(string: correctAnswerImage)
            imgPokemon.kf.setImage(with: url)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false ){ Timer in
                self.pokemonManager.fetchPokeon()
                self.lblRespuesta.text =  " "
                sender.layer.borderWidth = 0
                
            }
        }else{
            //checkAndShowAppropriateScreen(game.score)
            intentosIncorrectos += 1
            
            if intentosIncorrectos < 3 {
                
                let oportunidadesRestantes = 3 - intentosIncorrectos
                            // Informar al usuario sobre la respuesta incorrecta pero continuar el juego
                lblRespuesta.text = "Incorrecto. Te quedan \(oportunidadesRestantes) oportunidades. ¡Inténtalo de nuevo!"
                        } else {
                            // Se alcanzaron tres intentos incorrectos, ir a la pantalla de resultados
                            checkAndShowAppropriateScreen(game.score)
                        }
        }
    }
    //función para verificar y mostrar la pantalla
    func checkAndShowAppropriateScreen(_ newScore: Int) {
        var isHighScore = false

        for (index, jugador) in datos.jugadores.enumerated() {
            if newScore > jugador.puntuacion {
                isHighScore = true

                // Actualizar el jugador con el nuevo puntaje
                datos.jugadores[index].puntuacion = newScore

                break
            }
        }

        if isHighScore {
            // El nuevo puntaje es mayor que al menos uno de los puntajes existentes, muestra la pantalla para registrar el nuevo jugador
            performSegue(withIdentifier: "sgWin", sender: self)
        } else {
            // No es un nuevo récord, muestra la pantalla de resultados
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    
    
    func createButtons(){
        for button in btnOpciones{
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgWin" {
            let destination = segue.destination as! WinViewController
            destination.pokemonName = correctAnswer
            destination.pokemonImageURL = correctAnswerImage
            destination.finalScore = game.score
            resetGame()
        } else if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultsViewController
            destination.pokemonName = correctAnswer
            destination.pokemonImageURL = correctAnswerImage
            destination.finalScore = game.score
            resetGame()
        }
        else if segue.identifier == "sgRegistro" {
            let destination = segue.destination as! RegistroViewController
            destination.finalScore = game.score
            resetGame()
            
        }
    }
    
    func resetGame(){
        self.pokemonManager.fetchPokeon()
        game.setScore(score: 0)
        lblScore.text = "Puntaje: \(game.score)"
        self.lblRespuesta.text = " "
        intentosIncorrectos = 0
    }
    
    func setButtonTitles() {
        for (index, button) in btnOpciones.enumerated(){
            DispatchQueue.main.async { [self] in
                button.setTitle(random4Pokemons[safe: index]?.name.capitalized, for: .normal)
            }
        }
    }
}

extension PokemonViewController:PokemonManagerDelegate{
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        random4Pokemons = pokemons.choose(5)
    
        
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemons[index].imageURL
        correctAnswer = random4Pokemons[index].name
        
        
        imageManager.fetchImage(url: imageData)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension PokemonViewController: ImageManagerDelegate{
    func didUpdateImage(image: ImageModel) {
        correctAnswerImage = image.imageURL
        
        DispatchQueue.main.async {
            let url = URL(string: image.imageURL)
            
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
            self.imgPokemon.kf.setImage(
                with: url,
                options:[
                    .processor(effect)
                ]
                        )
        }
        
    }
    
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    
}

extension Collection where Indices .Iterator.Element == Index{
    public subscript(safe index: Index) ->Iterator .Element?{
        return (startIndex <= index && index  < endIndex) ? self[index] : nil
    }
}
extension Collection{
    func choose(_ n: Int) -> Array<Element>{
        Array(shuffled().prefix(n))
    }
}
