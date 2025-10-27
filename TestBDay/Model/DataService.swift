//
//  Child.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import Foundation
import SwiftData

struct DataService: DataServiceProtocol {
    var modelContext: ModelContext
    
    func save() -> Error? {
        do {
            try modelContext.save()
            return nil
        } catch {
            return error
        }
    }
    
    func fetch<T: PersistentModel>(type: T.Type) -> [T] {
        do {
            let descriptor = FetchDescriptor<T>()
            return  try modelContext.fetch(descriptor)
        } catch {
            print("Failed : \(error)")
            return []
        }
    }
    
    func insert<T: PersistentModel>(model: T) {
        modelContext.insert(model)
    }
    
    func delete<T: PersistentModel>(model: T) {
        modelContext.delete(model)
    }
}
