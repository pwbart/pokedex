//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paul Bartholomew on 19/05/2017.
//  Copyright © 2017 Paul Bartholomew. All rights reserved.
//

import Foundation

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
