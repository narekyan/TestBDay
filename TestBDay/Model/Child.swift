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
}
