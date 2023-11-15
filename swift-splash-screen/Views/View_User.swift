//
//  View_User.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_User: View {
    var body: some View {
        ZStack{
            Color.cyan
                .edgesIgnoringSafeArea(.top)
            Circle()
                .scale(1.75)
                .foregroundColor(.white.opacity(0.15))
            Ellipse()
                .scale(0.8)
                .foregroundColor(.white.opacity(0.25))
            VStack {
                Image("user_img")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .overlay(Circle().stroke(Color.orange, lineWidth: 3))
                Text("User Name")
                    .foregroundColor(.blue)
                    .font(.system(size: 25))
                    .bold()
                    .padding()
            }
        }
    }
}

#Preview {
    View_User()
}
