//
//  Publify_DigitalApp.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

@main
struct Publify_Digital_iOSApp: App {
    
    // Initialising custom TabBar (bottom) and NavigationBar (top) appearances
    init() {
        CustomTabBarAppearance.setupAppearance()
        CustomNavigationBarAppearance.setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
