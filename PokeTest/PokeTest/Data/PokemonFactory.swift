//
//  PokemonFactory.swift
//  PokeTest
//
//  Created by narek on 31.10.25.
//


class PokemonFactory {
    static func createPokemonRepository() -> PokemonRepositoryProtocol {
        PokemonRepository(apiService: ApiService(baseUrl: AppConfig.PokemonBaseUrl))
    }
}
