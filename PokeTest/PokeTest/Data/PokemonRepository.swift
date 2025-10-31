//
//  PokemonRepository.swift
//  PokeTest
//
//  Created by narek on 31.10.25.
//

import Foundation
import UIKit

protocol PokemonRepositoryProtocol {
    func getPokemons() async -> [Pokemon]
    func getPokemon(name: String) async -> Pokemon?
}

struct PokemonEndpoint: Endpoint {
    var rawValue: String {
        "pokemon/\(name ?? "")?limit=\(limit)"
    }
    
    private var limit: Int
    private var name: String?
    init(name: String? = nil, limit: Int = 20) {
        self.name = name
        self.limit = limit
    }
}

struct PokemonImageEndpoint: Endpoint {
    var rawValue: String {
        url
    }
    
    private var url: String
    init(url: String) {
        self.url = url
    }
}

class PokemonRepository: PokemonRepositoryProtocol {
    private var apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getPokemons() async -> [Pokemon] {
        struct PokemonResponse: Codable {
            let results: [Pokemon]
        }
        
        let response: PokemonResponse? = await apiService.get(endpoint: PokemonEndpoint(limit: 1000))
        guard let response else {
            return [] // error prpopogating later
        }
        return response.results
    }
    
    func getPokemon(name: String) async -> Pokemon? {
        let response: Pokemon? = await apiService.get(endpoint: PokemonEndpoint(name: name))
        guard var response, let imageUrl = response.frontImageURL else {
            return nil
        }
        let imageData = (try? await URLSession.shared.data(from: imageUrl))?.0 ?? Data()
        response.uiImage = UIImage(data: imageData)
        
        return response
    }
    
    
}
