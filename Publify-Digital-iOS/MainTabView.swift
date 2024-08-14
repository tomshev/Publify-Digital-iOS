//
//  MainTabView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject private var scannedCodeModel = ScannedCodeModel()
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            // First tab - QR Code Scanner
            QRCodeScannerView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }
                .tag(0)
                // Environment object is needed for sharing scanned code data across views
                .environmentObject(scannedCodeModel)
            
            // Second tab - Active Interaction
            ActiveView()
                .tabItem {
                    Image(systemName: "play.fill")
                    Text("Active")
                }
                .tag(1)
                // Environment object is needed for sharing scanned code data across views
                .environmentObject(scannedCodeModel)
            
            // Third tab - Map
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(2)
            
            // Fourth tab - Profile
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
