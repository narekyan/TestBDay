//
//  DetailsScreen.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import SwiftUI
import SwiftData

struct DetailsScreen: View {
    var body: some View {
        VStack() {
            NavigationLink("Show birthday screen") {
                BirthdayScreen()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Nanit birthday App")
    }
}

#Preview {
    DetailsScreen()
}
