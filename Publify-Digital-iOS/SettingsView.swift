//
//  SettingsView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                // Action and logic for changing email will go here
            }) {
                Text("Change Email")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            }
            
            Button(action: {
                // Action and logic for changing password will go here
            }) {
                Text("Change Password")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            }
            
            Button(action: {
                // Action and logic for logging out will go here
            }) {
                Text("Sign Out")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.red)
                    .cornerRadius(15)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
