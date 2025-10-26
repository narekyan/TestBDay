//
//  Child.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import Foundation
import SwiftData

@Model
final class Child {
    var name: String
    var birthday: Date
    @Attribute(.externalStorage) var photoData: Data?

    init(name: String, birthday: Date, photoData: Data? = nil) {
        self.name = name
        self.birthday = birthday
        self.photoData = photoData
    }
    
    func timeDifferenceYearsMonths() -> (years: Int, months: Int) {
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month], from: birthday, to: now)
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        
        return (years, months)
    }
}
