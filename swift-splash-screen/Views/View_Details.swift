//
//  View_Details.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Details: View {
    var item: MediaItem

    @EnvironmentObject private var mvm: MediaViewModel
    @State var selection: String = "Views"
    
    var body: some View {
        ZStack {
            ItemBackgroundImg(imgUrl: item.posterPath)
            
            ScrollView {
                
                ZStack {
                    ItemImage(imgUrl: item.backdropPath ?? "")
                    RoundAddToFavourites(itemId: item.id)
                }
                
                Text((item.name ?? item.title) ?? "Title Unknown")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top, 5)
                
                HStack {
                    HStack {
                        Text(Image(systemName: "calendar"))
                            .font(.system(size: 20))
                        Text((item.firstAirDate ?? item.releaseDate)?.prefix(4) ?? "")
                            .font(.system(size: 20))
                    }
                    Spacer()

                    HStack {
                        Text(Image(systemName: "star.fill"))
                            .font(.system(size: 20))
                            .foregroundStyle(Color.orange.opacity(Double(item.voteAverage ?? 0.0)/10 + 0.25))
                        Text(String(format:"%.2f", item.voteAverage ?? 0.0)
                               + " (\(String(item.voteCount ?? 0)))" )
                    .font(.system(size: 20))
                    }
                    Spacer()

                    HStack {
                        Text(Image(systemName: "eye"))
                            .font(.system(size: 20))
                        Text(String(Int(item.popularity ?? 0.0)))
                            .font(.system(size: 20))
                    }
                }.padding(.top, 1)
                
                YTButtonView(item: item)
                    .padding(.top, 5)
                                
                Text(item.overview)
                    .italic()
                    .font(.system(size: 20))
                    .padding(.top, 8)

            }.padding(.horizontal)
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
                .cornerRadius(10)
        }, placeholder: {
            Image(systemName: "film")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
        })
    }
}

struct ButtonAddToFavourites: View {
    var itemId: Int
    @EnvironmentObject private var mvm: MediaViewModel
        
    var body: some View {
        HStack {
            Spacer()
            Text(Image(
                systemName: mvm.favotiteIds.contains(itemId)
                ? "heart.fill"
                : "heart"))
            .bold()
            .font(.system(size: 30))
            .frame(width: 60, height: 40)
            .foregroundColor(.orange)
            .background(Color.primary.opacity(0.75))
            .cornerRadius(20)
            
            .onTapGesture {
                mvm.toggleFavorite(itemId: itemId)
            }
        }
    }
}

struct RoundAddToFavourites: View {
    var itemId: Int
    @EnvironmentObject private var mvm: MediaViewModel
        
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Text(Image(
                    systemName: mvm.favotiteIds.contains(itemId)
                        ? "heart.fill"
                        : "heart"))
                    .bold()
                    .font(.system(size: 30))
                    .frame(width: 40, height: 40)
                    .foregroundColor(.orange)
                    .background(Color.primary.opacity(0.75))
                    .cornerRadius(20)

                    .onTapGesture {
                        mvm.toggleFavorite(itemId: itemId)
                    }
            }
            Spacer()
        }
        .padding(5)
    }
}

#Preview {
    View_Details(item: dummyItem)
        .environmentObject(MediaViewModel())
}
