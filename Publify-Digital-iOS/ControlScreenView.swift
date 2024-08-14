//
//  ControlScreenView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 13/07/2024.
//

import SwiftUI

struct ControlScreenView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImageIndex = 0
    @State private var isAutoScrolling = false
    @State private var autoScrollTimer: Timer?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Scroll through current ads horizontally")
                    .font(.headline)
                    .padding()
                    .padding(.top, 9)
                    .foregroundColor(.gray)
                
                // Image scrollable 'gallery' with dot indicators
                TabView(selection: $selectedImageIndex) {
                    
                    Image("Ad_1")
                        .resizable()
                        .scaledToFill()
                        .tag(0)
                    
                    Image("Ad_2")
                        .resizable()
                        .scaledToFill()
                        .tag(1)
                    
                    Image("Ad_3")
                        .resizable()
                        .scaledToFill()
                        .tag(2)
                    
                    // Extra image for looping functionality
                    Image("Ad_1")
                        .resizable()
                        .scaledToFill()
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 500)
                .cornerRadius(15)
                .padding(.horizontal)
                .onChange(of: selectedImageIndex) { newIndex in
                    if newIndex == 3 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            selectedImageIndex = 0
                        }
                    }
                }
                
                // Button to start auto-scrolling of ads
                Button(action: {
                    toggleAutoScrolling()
                }) {
                    Text(isAutoScrolling ? "Stop Auto-Scroll" : "Start Auto-Scroll")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(isAutoScrolling ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Control Screen")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Exit") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    // Function for auto-scrolling ads
    private func toggleAutoScrolling() {
        
        isAutoScrolling.toggle()
        
        if isAutoScrolling {
            autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                withAnimation {
                    if selectedImageIndex < 3 {
                        selectedImageIndex += 1
                    } else {
                        selectedImageIndex = 0
                    }
                }
            }
            
        } else {
            autoScrollTimer?.invalidate()
            autoScrollTimer = nil
        }
    }
}

struct ControlScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ControlScreenView()
    }
}
