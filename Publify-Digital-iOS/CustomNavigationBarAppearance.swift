//
//  CustomNavigationBarAppearance.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct CustomNavigationBarAppearance {
    
    static func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // Customising background color
        appearance.backgroundColor = UIColor.systemGray6
        // Customising title color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        // Customising large title color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
