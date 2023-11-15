//
//  View-Home.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Home: View {
    
    private var adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
//                ForEach(movies) { movie in SingleTile(item: movie) }
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(movies) { movie in
                        SinglePoster(item: movie)
                    }
                }
                .padding()
            }
        }.navigationViewStyle(.stack)
    }
}

struct SinglePoster: View {
    var item: Item
    
    var body: some View {
        NavigationLink(destination: View_Details(id: item.id)) {
            Image(item.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 170, height: 255)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
                .shadow(color: .secondary, radius: 10)
        }
    }
}

//struct SingleTile: View {
//    var item: Item
//    
//    var body: some View {
//        NavigationLink(destination: View_Details(id: item.id)) {
//            Image(item.imgSrc)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(10)
//                .padding([.top, .leading, .trailing])
//                .shadow(color: .black, radius: 15)
//        }
//    }
//}

#Preview {
    View_Home()
}
