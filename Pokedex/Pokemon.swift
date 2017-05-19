//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paul Bartholomew on 19/05/2017.
//  Copyright © 2017 Paul Bartholomew. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
        
        self._pokemonURL = "\(URL_Base)\(URL_POKEMON)\(self.pokedexID)"
    }
    
    func downloadPokemonDetails(completed:@escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.value as? [String:Any] {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                
                print(self._weight, self._height, self._attack, self._defense)
                
                if let types = dict["types"] as? [[String:String]], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for obj in 1..<types.count {
                            if let name = types[obj]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [[String:String]], descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let descriptionUrl = "\(URL_Base)\(url)"
                        Alamofire.request(descriptionUrl).responseJSON { response in
                            if let descDict = response.result.value as? [String:Any] {
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                if let evolutions = dict["evolutions"] as? [[String:Any]], evolutions.count > 0 {
                    if let nextEvoultion = evolutions[0]["to"] as? String {
                        if nextEvoultion.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvoultion
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoString = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionID = nextEvoString
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let level = lvlExist as? Int {
                                        self._nextEvolutionLevel = String(level)
                                    }
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
}
