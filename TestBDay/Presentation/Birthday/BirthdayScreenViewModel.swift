import Foundation
import SwiftData
import Combine
import UIKit

@MainActor
final class BirthdayScreenViewModel: ObservableObject {
    
    struct Age {
        let years: Int
        let months: Int
    }
    
    let randomNumber: Int
    var photoBgSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 480
        }
        return 240
    }
    var photoBgRadiusWithPadding: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return photoBgSize / 2 + 90
        }
        return photoBgSize / 2 + 45
    }
    
    let name: String
    let age: Age
    
    var numberPictureResource: String {
        age.years > 0 ? "\(age.years)" : "\(age.months)"
    }
    
    var upperTextResource: String {
        "TODAY \(name.uppercased()) IS"
    }
    
    var underTextResource: String {
        if age.years > 0  {
            if age.years == 1 {
                return "YEAR OLD!"
            } else {
                return "YEARS OLD!"
            }
        } else {
            if age.months <= 1 {
                return "MONTH OLD!"
            } else {
                return "MONTHS OLD!"
            }
        }
    }

    
    @Published var photoData: Data? {
        didSet {
            save()
        }
    }
    
    var modelContext: ModelContext?
    private var child: Child
    
    init(child: Child) {
        self.child = child
        
        randomNumber = Int.random(in: 1...3)
        name = child.name
        let age = child.timeDifferenceYearsMonths()
        self.age = Age(years: age.0, months: age.1)
        photoData = child.photoData
    }
    
    private func save() {
        guard let modelContext else { return }
        
        child.photoData = photoData
        
        do {
            try modelContext.save()
        } catch {
            print("Failed: \(error)")
        }
    }
}
