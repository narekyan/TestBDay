import SwiftUI
import Combine

@MainActor
final class DetailsScreenViewModel: ObservableObject {
    @Published var children: [Child] = []
    @Published var errorMessage: String?
    var dataService: DataServiceProtocol?

    func fetchChildren() {
        self.children = dataService?.fetch(type: Child.self) ?? []
        if children.isEmpty {
            createChild() // for first child
        }
    }
    
    func createChild() {
        guard let dataService else { return }
        
        let child = Child(name: "", birthday: Date())
        dataService.insert(model: child)
        let error = dataService.save()
        if error != nil {
            errorMessage = error?.localizedDescription
            return
        }
        self.children.append(child)
    }
    
    func removeRecord(_ index: Int) {
        guard let dataService else { return }
        
        let child = children[index]
        dataService.delete(model: child)
        let error = dataService.save()
        if error != nil {
            errorMessage = error?.localizedDescription
            return
        }
        children.remove(at: index)
    }
}
