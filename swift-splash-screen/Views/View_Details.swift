//
//  View_Details.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Details: View {
    var item: MediaItem
        
    var body: some View {
        ZStack {
            ItemBackgroundImg(imgUrl: item.posterPath)
            ScrollView {
                ItemImage(imgUrl: item.backdropPath)
                Text((item.name ?? item.title) ?? "Title")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30))
                    .bold()
                    .padding(3)
                Text((item.firstAirDate ?? item.releaseDate)?.prefix(4) ?? "Year")
                    .font(.system(size: 20))
                NavigationLink(destination: View_Player()) {
                    ButtonPlay()
                }
                Text(item.overview).italic().padding().font(.system(size: 20))
            }
        }
    }
}

struct ItemBackgroundImg: View {
    var imgUrl: String
    
    private let baseUrl = "https://image.tmdb.org/t/p/w500/"
    
    var body: some View {
        AsyncImage(url: URL(string: baseUrl + imgUrl), content: { resImg in
            resImg
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.2)
                .offset(x:0, y:130)
        }, placeholder: {})
    }
}

struct ItemImage: View {
    var imgUrl: String
    
    private let baseUrl = "https://image.tmdb.org/t/p/w500/"
    
    var body: some View {
        AsyncImage(url: URL(string: baseUrl + imgUrl), content: { resImg in
            resImg
                .resizable()
                .aspectRatio(contentMode: .fill)
        }, placeholder: {
            Image(systemName: "film")
                .resizable()
                .aspectRatio(contentMode: .fill)
        })
    }
}

struct ButtonPlay: View {
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

//#Preview {
//    View_Details(id: 2)
//}
