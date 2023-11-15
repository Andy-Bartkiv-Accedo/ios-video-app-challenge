//
//  View_Search.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Search: View {
    
    @State private var search = ""
    
    var body: some View {
        ZStack{
            Color.teal
                .edgesIgnoringSafeArea(.top)
            Circle()
                .scale(1.65)
                .foregroundColor(.white.opacity(0.25))
            Circle()
                .scale(1.25)
                .foregroundColor(.white.opacity(0.75))
            
            VStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.teal)
                .font(.system(size: 75.0))
                
                TextField("Search...", text: $search)
                    .padding()
                    .fontWeight(.bold)
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                
                Button("Explore") {
                    search = ""
                }
                .foregroundColor(.white)
                .font(.system(size: 25.0))
                .frame(width: 300, height: 50)
                .background(Color.teal.opacity(0.75))
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    View_Search()
}
