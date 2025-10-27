//
//  Child.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import Foundation
import SwiftData

protocol DataServiceProtocol {
    var modelContext: ModelContext { set get }
    
    func save() -> Error?
    func fetch<T: PersistentModel>(type: T.Type) -> [T]
    func insert<T: PersistentModel>(model: T)
    func delete<T: PersistentModel>(model: T)
}
