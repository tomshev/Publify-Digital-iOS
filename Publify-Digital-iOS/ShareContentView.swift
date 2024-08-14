//
//  ShareContentView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 13/07/2024.
//

import SwiftUI
import PhotosUI

struct ShareContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var isSharing = false
    @State private var timerRemaining = 60
    @State private var timer: Timer?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Upload your ad or content")
                    .font(.headline)
                    .padding()
                    .padding(.top, 9)
                    .foregroundColor(.gray)
                
                ZStack {
                    
                    Rectangle()
                        .frame(height: 500)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                    
                    // If images is uploaded, display it here
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 500)
                            .cornerRadius(15)
                            .clipped()
                            .padding(.horizontal)
                        
                    // Else, display a prompt to upload image
                    } else {
                        Text("Tap to upload a photo")
                            .foregroundColor(.gray)
                    }
                    
                    // SwiftUI image selector
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Rectangle()
                            .frame(height: 500)
                            .foregroundColor(.clear)
                            .cornerRadius(15)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImage = uiImage
                            }
                        }
                    }
                    
                    // Show timer when sharing image to public screen
                    if isSharing {
                        Text("Time remaining: \(timerRemaining)s")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .padding()
                    }
                }
                
                // Button for submitting the image to screen
                // In real scenario it would send it to AI detection first
                Button(action: {
                    if selectedImage != nil {
                        toggleSharing()
                    }
                }) {
                    Text(isSharing ? "Stop Sharing" : "Submit & Check")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(isSharing ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                
                // Important notice
                Text("VERIFICATION WITH GOVERNMENT ID IS REQUIRED FOR SHARING PERSONAL ADS OR CONTENT. GO TO PROFILE TAB. TERMS AND CONDITIONS, PRIVACY POLICY APPLY. BY SUBMITTING YOU AGREE THAT YOUR CONTENT WILL BE SCANNED BY DETECTION MODELS.")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                
                Spacer()
            }
            .navigationTitle("Share Content")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                // Button for removing the uploaded image
                leading: Button("Clear") {
                    selectedImage = nil
                    selectedItem = nil
                },
                trailing: Button("Exit") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    // Button cause the action depending on the current state
    private func toggleSharing() {
        if isSharing {
            stopSharing()
        } else {
            startSharing()
        }
    }
    
    // Logic for starting the sharing, currently only starts timer
    private func startSharing() {
        isSharing = true
        timerRemaining = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timerRemaining > 0 {
                timerRemaining -= 1
            } else {
                stopSharing()
            }
        }
    }
    
    // Logic for stopping the sharing and resetting selected items
    private func stopSharing() {
        isSharing = false
        timer?.invalidate()
        timer = nil
        selectedImage = nil
        selectedItem = nil
    }
}

struct ShareContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShareContentView()
    }
}




