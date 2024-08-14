//
//  ScannedCodeModel.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

class ScannedCodeModel: ObservableObject {
    
    @Published var scannedCode: String?
    @Published var shouldResetScanner: Bool = false
}
