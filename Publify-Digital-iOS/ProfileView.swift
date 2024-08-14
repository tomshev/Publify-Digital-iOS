//
//  ProfileView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 30) {
                
                HStack(spacing: 35) {
               
//                    Image(systemName: "trash.fill")
//                        .font(.system(size: 40))
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    // Profile picture
                    Image("PublifyDigital-JJ")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        
                        .shadow(radius: 5)
                    
//                    Image(systemName: "pencil")
//                        .font(.system(size: 40))
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                
                VStack(spacing: 10) {
                    
                    // First name field
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 50)
                        .overlay(
                            
                            HStack {
                                
                                Text("First name:")
                                    .bold()
                                Text("John")
                            }
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        )
                    
                    // Last name field
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 50)
                        .overlay(
                            
                            HStack {
                                
                                Text("Last name:")
                                    .bold()
                                Text("Jonnes")
                            }
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        )
                    
                    // Email field
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 50)
                        .overlay(
                            HStack {
                                Text("Email:")
                                    .bold()
                                Text("JOHN@JONNES")
                            }
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        )
                }
                
                Divider()
                
                // Account verification field
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 50)
                    .overlay(
                        
                        VStack {
                            
                            HStack {
                                
                                Text("Account not verified")
                                    
                                    .foregroundColor(.red)
                                Spacer()
                                Button("Verify") {
                                    // Action and logic for verifying will go here
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    )
                
                // Important notice
                Text("VERIFICATION WITH GOVERNMENT ID IS REQUIRED FOR SHARING PERSONAL ADS OR CONTENT. VERIFICATION IS DONE BY THIRD PARTY COMPANY 'COMPANY'. TERMS AND CONDITIONS, PRIVACY POLICY APPLY")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
            }
            .padding()
            .padding(.top, 20)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            // Link to settings view
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Text("Settings")
                            Image(systemName: "gearshape.fill")
                        }
                    }
                }
            // Link to help view
            .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: HelpView()) {
                            Image(systemName: "questionmark.circle.fill")
                            Text("Help")
                        }
                    }
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}





        
