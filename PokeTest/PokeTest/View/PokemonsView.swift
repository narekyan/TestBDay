//
//  ContentView.swift
//  PokeTest
//
//  Created by narek on 31.10.25.
//

import SwiftUI
import SwiftData

struct PokemonsView: View {
    @StateObject var viewModel: PokemonsViewModel
    
    init () {
        _viewModel = StateObject(wrappedValue: PokemonsViewModel(respository: PokemonFactory.createPokemonRepository()))
    }
    
    var body: some View {
        List {
            ForEach(Array(viewModel.pokemons.enumerated()), id: \.element.name) { index, item in
                HStack {
                    if let uiImage = item.uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding()
                    } else {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                        
                    Text(item.name.capitalized)
                }
                .task {
                    await viewModel.fetchPokemon(index: index)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemons()
            }
        }
    }
    
}

#Preview {
    PokemonsView()
        .modelContainer(for: Item.self, inMemory: true)
}
