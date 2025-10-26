//
//  BirthdayScreen.swift
//  TestBDay
//
//  Created by narek on 24.10.25.
//

import SwiftUI
import UIKit

struct BirthdayScreen: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: BirthdayScreenViewModel
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showAction = false
    @State private var showPicker = false
    @State private var prepareForScreenshot = false
    
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
                        if !prepareForScreenshot {
                            Button(action: {
#if targetEnvironment(simulator)
                                showPicker = true
#else
                                showAction = true
#endif
                            }) {
                                Image("camera.\(viewModel.randomNumber)")
                            }
                            .padding([.leading, .bottom], viewModel.photoBgRadiusWithPadding)
                        }
                    }
                    .padding(.vertical, 15)
                    Image("nanit")
                }
            }
            .padding()
            .frame(height: UIScreen.main.bounds.height / 2 + viewModel.photoBgRadiusWithPadding)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .ignoresSafeArea()
        .navigationBarHidden(prepareForScreenshot)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    prepareForScreenshot = true

                    viewModel.shareCurrentScreen()
                    
                    prepareForScreenshot = false
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
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

#Preview {
    NavigationStack { BirthdayScreen(child: Child(name: "Baby", birthday: Date())) }
}
