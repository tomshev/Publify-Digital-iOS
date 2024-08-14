//
//  WelcomeView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMainTabView: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Spacer()
                
                Image("PublifyDigital-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 100)
                
                Text("ACCESS AND CONTROL PUBLIC DISPLAYS IN YOUR AREA")
                    .padding(.horizontal, 70)
                    .multilineTextAlignment(.center)
                    .overlay {
                        LinearGradient(
                            colors: [.blue, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                            )
                    }
                    .mask(
                        Text("ACCESS AND CONTROL PUBLIC DISPLAYS IN YOUR AREA")
                            .font(Font.system(size: 15, weight: .bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                    )
                
                Spacer()
                
                VStack {
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                    
                    // When authentication ir performed and button is pressed,
                    // MainTabView opens
                    Button(action: {
                        self.showMainTabView = true
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .padding(10)
                            .frame(width: 180, height: 50)
                            .background(Color(.blue))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding()
                    .fullScreenCover(isPresented: $showMainTabView) {
                        MainTabView()
                    }
                    
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                            .font(Font.system(size: 14, weight: .regular))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: SignUpView()) {
                    Text("Create an Account")
                        .font(.headline)
                        .padding()
                        .frame(width: 180, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

