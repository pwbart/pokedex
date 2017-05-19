//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paul Bartholomew on 19/05/2017.
//  Copyright © 2017 Paul Bartholomew. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
    }
    
}
