//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Paul Bartholomew on 19/05/2017.
//  Copyright © 2017 Paul Bartholomew. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var evoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        evoImage.image = img
        nameLbl.text = "\(pokemon.name.capitalized)"
        
        pokemon.downloadPokemonDetails { 
            // whatever we write here will only be called after the network call is complete
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        baseAttackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionID == "" {
            evolutionLbl.text = "No evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionID)
            let str = "Next evolution: \(pokemon.nextEvolutionName) - Level: \(pokemon.nextEvolutionLevel)"
            evolutionLbl.text = str
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
    


}
