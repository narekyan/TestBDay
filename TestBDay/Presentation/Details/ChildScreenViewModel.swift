import Foundation
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
    @Published var errorMessage: String?
    
    var isNewChild: Bool {
        child.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var dataService: DataServiceProtocol?
    private var child: Child
    
    init(child: Child) {
        self.child = child
        
        name = child.name
        birthday = child.birthday
        photoData = child.photoData
    }
    
    private func save() {
        guard let dataService else { return }
        
        child.name = name
        child.birthday = birthday
        child.photoData = photoData
    
        let error = dataService.save()
        errorMessage = error?.localizedDescription
    }
}
