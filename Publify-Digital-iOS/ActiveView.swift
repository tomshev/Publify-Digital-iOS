//
//  HistoryView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct ActiveView: View {
    
    @EnvironmentObject var scannedCodeModel: ScannedCodeModel
    @State private var showControlScreen = false
    @State private var showShareContent = false
    @State private var showPlayGame = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.2))
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 70)
                    
                    // Field for display code and its location
                    VStack {
                        
                        Text("Display: \(scannedCodeModel.scannedCode ?? "UNDEFINED")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        Text("Located: \(location)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                                        
                    }
                }
                .padding(.horizontal)
                
                // Button for disconnecting from screen and stopping active interaction
                Button(action: {
                    self.disconnect()
                }) {
                    Text("Disconnect")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .padding(.bottom, 2)
                
                // Conditionally show the available options if location is not UNDEFINED
                if location != "UNDEFINED" {
                    Text("Available options:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    // Button for opening screen control view
                    Button(action: {
                        self.showControlScreen = true
                    }) {
                        Text("Control screen")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.gray.opacity(0.15))
                            .foregroundColor(.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .fullScreenCover(isPresented: $showControlScreen) {
                        ControlScreenView()
                    }
                    
                    // Button for opening personal content sharing view
                    Button(action: {
                        self.showShareContent = true
                    }) {
                        Text("Share your ad or content")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.gray.opacity(0.15))
                            .foregroundColor(.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .fullScreenCover(isPresented: $showShareContent) {
                        ShareContentView()
                    }
                    
                    // Button for opening game view
                    Button(action: {
                        self.showPlayGame = true
                    }) {
                        Text("Play a game")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .fullScreenCover(isPresented: $showPlayGame) {
                        PlayGameView()
                    }
                }
                
                Spacer()
                
            }
            .navigationTitle("Active Interaction")
            .navigationBarTitleDisplayMode(.large)
            .padding(.top)
        }
    }
    
    // Cases for display data
    // For prototype testing purposes
    private var location: String {
        switch scannedCodeModel.scannedCode {
        case "PD-NCL-100250":
            return "Newcastle, Eldon Square"
        case "PD-VLN-200370":
            return "Vilnius, Akropolis"
        case "SimulatedQRCode1234":
            return "Simulator"
        default:
            return "UNDEFINED"
        }
    }
    
    // Reseting the scanner in the backend when disconnected
    private func disconnect() {
        scannedCodeModel.scannedCode = nil
        scannedCodeModel.shouldResetScanner = true
    }
}

struct ActiveView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveView().environmentObject(ScannedCodeModel())
    }
}


