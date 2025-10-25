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
                if let child = viewModel.children.first {
                    VStack {
                        ChildScreen(child: child) {
                            path.append("BD")
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .background(.cyan)
            .navigationTitle("Nanit birthday App")
            .onAppear {
                if viewModel.modelContext == nil {
                    viewModel.modelContext = modelContext
                    viewModel.fetchChildren()
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "BD" {
                    BirthdayScreen()
                }
            }   
        }
    }
}

#Preview {
    DetailsScreen()
}
