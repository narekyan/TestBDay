//
//  DetailsScreen.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import SwiftUI
import SwiftData
import Combine

struct DetailsScreen: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: DetailsScreenViewModel
    @State private var path = NavigationPath()
    @State private var currentPage = 0
    
    init() {
        _viewModel = StateObject(wrappedValue: DetailsScreenViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack() {
                TabView(selection: $currentPage) {
                    ForEach(viewModel.children.indices, id: \.self) { index in
                        let child = viewModel.children[index]
                        VStack {
                            ChildScreen(child: child) {
                                path.append(child)
                            }
                            
                            Button(action: {
                                viewModel.removeRecord(index)
                            }) {
                                Text("Remove record")
                            }
                            .tint(.red)
                            .buttonStyle(.borderedProminent)
                            
                            Spacer().frame(height: 40)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            }
            .padding(.horizontal, 20)
            .background(.cyan)
            .navigationTitle("Nanit birthday App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.createChild()
                        currentPage = viewModel.children.count - 1
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                if viewModel.dataService == nil {
                    viewModel.dataService = DataService(modelContext: modelContext)
                    viewModel.fetchChildren()
                }
            }
            .navigationDestination(for: Child.self) { value in
                BirthdayScreen(child: value)
            }
        }
    }
}

#Preview {
    DetailsScreen()
}
