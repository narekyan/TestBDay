//
//  BirthdayScreen.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import SwiftUI

struct BirthdayScreen: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: BirthdayScreenViewModel
    
    init(child: Child) {
        _viewModel = StateObject(wrappedValue: BirthdayScreenViewModel(child: child))
    }
    
    var body: some View {
        ZStack {
            Color("bg.color.\(viewModel.randomNumber)")
            VStack {
                Spacer()
                Image("bg.screen.\(viewModel.randomNumber)")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width)
            }
            VStack {
                Spacer().frame(height: 40)
                VStack() {
                    Text(viewModel.upperTextResource)
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack {
                        Image("rightswirls").rotationEffect(Angle(degrees: 180))
                        Image(viewModel.numberPictureResource)
                            .padding(.horizontal, 22)
                        Image("rightswirls")
                    }
                    .padding(.vertical, 13)
                    Text(viewModel.underTextResource)
                        .fontWeight(.bold)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 50)
                
                VStack {
                    ZStack {
                        Image("photo.\(viewModel.randomNumber)")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: viewModel.photoBgSize)
                        if let data = viewModel.photoData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxHeight: viewModel.photoBgSize - 15, alignment: .center)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.vertical, 15)
                    Image("nanit")
                }
            }
            .padding()
            .frame(height: UIScreen.main.bounds.height / 2 + viewModel.photoBgSize / 2 + 40)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack { BirthdayScreen(child: Child(name: "Baby", birthday: Date())) }
}
