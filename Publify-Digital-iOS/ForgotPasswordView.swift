//
//  ForgotPasswordView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    
    var body: some View {
        
        VStack {
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
            
            Button(action: {
                // Password reset action logic will go here in the future
            }) {
                Text("Reset Password")
                    .font(.headline)
                    .padding(10)
                    .frame(width: 180, height: 50)
                    .background(Color(.black))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding()
        }
        .padding()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
