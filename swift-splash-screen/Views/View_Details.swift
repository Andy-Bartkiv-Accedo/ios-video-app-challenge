//
//  View_Details.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Details: View {
    var id: Int
        
    var body: some View {
        ZStack {
            Image(movies[id].poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.2)
                .offset(x:0, y:130)
            ScrollView {
                Image(movies[id].imgSrc)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Text(movies[id].title)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30))
                    .bold()
                    .padding(3)
                Text(movies[id].year).font(.system(size: 20))
                NavigationLink(destination: View_Player()) {
                    Button_Play()
                }
                Text(movies[id].description).italic().padding().font(.system(size: 20))
            }
        }
    }
}

struct Button_Play: View {
    var body: some View {
        Image(systemName: "play.fill")
            .frame(width: 365, height: 65)
            .font(.system(size: 30))
            .foregroundColor(.white)
            .background(Color.teal)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

#Preview {
    View_Details(id: 2)
}
