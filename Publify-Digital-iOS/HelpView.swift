//
//  HelpView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct HelpView: View {
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                // Action and logic for opening terms and condition will go here
            }) {
                Text("Terms and Conditions")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            }
            
            Button(action: {
                // Action and logic for opening privacy policy will go here
            }) {
                Text("Privacy Policy")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            }
            
            Button(action: {
                // Action and logic for opening FAQ will go here
            }) {
                Text("FAQ")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            }
            
            Button(action: {
                // Action and logic for opening support request form will go here
            }) {
                Text("Support Request")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.gray)
                    .cornerRadius(15)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
