//
//  QRCodeScannerView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct QRCodeScannerView: View {
    
    @State private var scannedCode: String?
    @State private var isScanning = true
    // UUID state variable is added and its updated when resetScanner is called,
    // ensuring QRCodeScannerVM is recreated
    @State private var resetScannerKey = UUID()
    @EnvironmentObject var scannedCodeModel: ScannedCodeModel
    @Binding var selectedTab: Int
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // If there is a successfully scanned code, display it and provide
                // further actions
                if let scannedCode = scannedCode {
                    
                    Text("Scanned QR Code: \(scannedCode)")
                        .padding()
                    
                    Button(action: {
                        self.resetScanner()
                    }) {
                        Text("Scan Another Code")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        self.tryToConnect()
                    }) {
                        Text("Try to Connect")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                
                // If there is no scanned code, keep scanning
                } else {
                    
                    VStack {
                        
                        Text("Align the code in the frame")
                            .padding()
                        
                        ZStack {
                            
                            if isScanning {
                                QRCodeScannerVM {
                                    self.scannedCode = $0
                                    self.scannedCodeModel.scannedCode = $0
                                    self.isScanning = false
                                }
                                .id(resetScannerKey) // Force recreation with a unique key
                                .frame(width: 250, height: 250)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                        .frame(width: 250, height: 250)
                                )
                            }
                        }
                        
                        Text("You have to be close to a public display")
                            .padding()
                    }
                }
            }
            // The flag is ovserved here, to reset scanner when needed
            .onAppear {
                if self.scannedCodeModel.shouldResetScanner {
                    self.resetScanner()
                    self.scannedCodeModel.shouldResetScanner = false
                }
            }
            .navigationTitle("QR Code Scanner")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // Function for resetting the scanner
    private func resetScanner() {
        self.scannedCode = nil
        self.isScanning = true
        // Change the key to force recreation
        self.resetScannerKey = UUID()
    }
    
    // Function for connected to the screen if it's code has been scanned
    private func tryToConnect() {
        self.scannedCodeModel.scannedCode = self.scannedCode
        self.selectedTab = 1
    }
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView(selectedTab: .constant(0)).environmentObject(ScannedCodeModel())
    }
}




