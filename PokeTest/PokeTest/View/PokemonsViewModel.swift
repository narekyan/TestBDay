//
//  PokemonsViewModel.swift
//  PokeTest
//
//  Created by narek on 31.10.25.
//

import Combine

class PokemonsViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    
    private var respository: PokemonRepositoryProtocol
    
    init(respository: PokemonRepositoryProtocol) {
        self.respository = respository
        
    }
    
    func fetchPokemons() async {
        pokemons = await respository.getPokemons()
    }
    
    func fetchPokemon(index: Int) async {
        let pokemon = pokemons[index]
        if let _ = pokemon.uiImage {
            return
        }
        guard let pokemon = await respository.getPokemon(name: pokemon.name) else {
            return
        }
        pokemons[index] = pokemon
    }
    
    func pokemonImageUrlFor(index: Int) -> String {
        pokemons[index].sprites?.frontDefault ?? ""
    }
}
