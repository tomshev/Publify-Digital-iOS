//
//  PlayGameView.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 13/07/2024.
//

import SwiftUI

struct PlayGameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Today's game: NEWCASTLE TRIVIA")
                    .font(.headline)
                    .padding()
                    .padding(.top, 9)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(height: 500)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .overlay { Image("Game_1")
                            .resizable()
                            .scaledToFill()}
                    .mask (Rectangle()
                        .frame(height: 500)
                        .cornerRadius(15)
                        .padding(.horizontal))
                
                Button(action: {
                    // Action and logic for starting the game will go here
                }) {
                    Text("START")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                
                Text("Questions will appear on the public screen. Select and sumbit correct answer on your device.")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                
                Spacer()
            }
            .navigationTitle("Game")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Exit") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct PlayGameView_Previews: PreviewProvider {
    static var previews: some View {
        PlayGameView()
    }
}
