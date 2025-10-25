import SwiftUI
import SwiftData

@MainActor
struct ChildScreen: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: ChildScreenViewModel
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showAction = false
    @State private var showPicker = false
    
    private let onShowBirthDay: () -> Void
    
    init(child: Child, onShowBirthDay: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: ChildScreenViewModel(child: child))
        self.onShowBirthDay = onShowBirthDay
    }
    
    var body: some View {
        Form(content: {
            Section(
                content: {
                ZStack(alignment: .leading) {
                    Text("Name")
                        .foregroundColor(.primary)
                    
                    TextField("", text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                }
            })
            .listSectionSpacing(.compact)
            
            Section(
                content: {
                DatePicker(
                    "Birthday",
                    selection: Binding(
                        get: { viewModel.birthday },
                        set: { viewModel.birthday = $0 }
                    ),
                    in: ...Date(),
                    displayedComponents: .date
                )
            })
            .listSectionSpacing(.compact)
            
            Section(content: {
                Button(action: {
#if targetEnvironment(simulator)
                    showPicker = true
#else
                    showAction = true
#endif
                }) {
                    VStack(alignment: .leading) {
                        Text("Select Photo")
                            .foregroundColor(.primary)
                        if let data = viewModel.photoData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxHeight: 300, alignment: .center)
                                .clipShape(Circle())
                        }
                    }
                }
            })
            .listSectionSpacing(.compact)
            
            Section {
                Button(action: {
                    onShowBirthDay()
                }) {
                    Text("Show birthday screen")
                        .frame(maxWidth: .infinity)
                }
                .disabled(viewModel.isNewChild)
                .buttonStyle(.borderedProminent)
                .listRowBackground(Color.clear)
            }
            .listSectionSpacing(.compact)
        })
        .scrollContentBackground(.hidden)
        .confirmationDialog("Select Photo", isPresented: $showAction) {
            Button("Camera") {
                pickerSource = .camera
                showPicker = true
            }
            Button("Photo Library") {
                pickerSource = .photoLibrary
                showPicker = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(imageData: $viewModel.photoData, sourceType: pickerSource)
        }
        .onAppear {
            if viewModel.modelContext == nil {
                viewModel.modelContext = modelContext
            }
        }
    }
}
