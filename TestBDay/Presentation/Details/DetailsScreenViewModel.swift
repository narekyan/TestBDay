import SwiftUI
import SwiftData
import Combine

@MainActor
final class DetailsScreenViewModel: ObservableObject {
    @Published var children: [Child] = []
    var modelContext: ModelContext?

    func fetchChildren() {
        guard let modelContext else { return }
        do {
            let descriptor = FetchDescriptor<Child>()
            self.children = try modelContext.fetch(descriptor)
            if children.isEmpty {
                createChild() // for first child
            }
        } catch {
            print("Failed : \(error)")
        }
    }
    
    func createChild() {
        let child = Child(name: "", birthday: Date())
        modelContext?.insert(child)
        do {
            try modelContext?.save()
        } catch {
            print("Failed : \(error)")
        }
        self.children.append(child)
    }
    
    func removeRecord(_ index: Int) {
        let child = children[index]
        children.remove(at: index)
        modelContext?.delete(child)
        do {
            try modelContext?.save()
        } catch {
            print("Failed : \(error)")
        }
    }
}
