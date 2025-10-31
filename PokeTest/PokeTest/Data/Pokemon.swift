//
//  Pokemon.swift
//  PokeTest
//
//  Created by narek on 31.10.25.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    var name: String
    var sprites: Sprite?
    var uiImage: UIImage?
    
    enum CodingKeys: CodingKey {
        case name
        case sprites
    }
    
    var frontImageURL: URL? {
        if let sprites, let url = URL(string: sprites.frontDefault) {
            return url
        }
        return nil
    }
}

struct Sprite: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
