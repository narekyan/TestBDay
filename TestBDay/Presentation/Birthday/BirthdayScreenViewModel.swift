import Foundation
import SwiftData
import Combine

@MainActor
final class ChildScreenViewModel: ObservableObject {
    
    @Published var name: String = "" {
        didSet {
            save()
        }
    }
    
    @Published var birthday: Date = Date() {
        didSet {
            save()
        }
    }
    @Published var photoData: Data? {
        didSet {
            save()
        }
    }
    
    var modelContext: ModelContext?
    private var child: Child
    var isNewChild: Bool {
        child.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init(child: Child) {
        self.child = child
        
        name = child.name
        birthday = child.birthday
        photoData = child.photoData
    }
    
    private func save() {
        guard let modelContext else { return }
        
        child.name = name
        child.birthday = birthday
        child.photoData = photoData
        
        do {
            try modelContext.save()
        } catch {
            print("Failed: \(error)")
        }
    }
}
