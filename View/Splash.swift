//
//  Untitled.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//

import SwiftUI

struct Splash: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            EmptyPage()
        } else {
            VStack (spacing:0) {
                Image("22")
                    .resizable()
                    .scaledToFit()
                    .frame(width:153, height:304.78)
                    .padding(.top,17)
                        
                Text("Journali")
                    .foregroundColor(Color .white)
                    .font(.system(size: 42).bold())
                    .padding(.top,-95)
                    .padding()
                
                Text("Your thoughts, your story")
                    .foregroundColor(Color .white)
                    .font(.system(size: 18))
                    .padding(.top,-50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.15),
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    Splash()
}

