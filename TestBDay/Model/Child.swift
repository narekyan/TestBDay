//
//  Item.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import Foundation
import SwiftData

@Model
final class Child {
    var birthday: Date
    
    init(birthday: Date) {
        self.birthday = birthday
    }
}
