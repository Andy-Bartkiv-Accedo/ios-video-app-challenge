//
//  View_Home.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Home: View {
    
    @EnvironmentObject private var mvm: MediaViewModel
        
    private var adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                if mvm.isRefreshing {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                            ForEach(mvm.mediaLibrary, id: \.id) { mediaItem in
                                ItemPoster(item: mediaItem)
                            }
                        }
                    }
                }
                FilterSortSelectorsTopBar()
            }
            .refreshable {
                Task {
                    await mvm.fetchAllData()
                }
            }
        }.navigationViewStyle(.stack)
    }
}

struct ItemPoster: View {
    var item: MediaItem
    
    private let assetsUrl = "https://image.tmdb.org/t/p/w500/"
    var body: some View {
        NavigationLink(destination: View_Details(item: item)) {
            AsyncImage(url: URL(string: assetsUrl + item.posterPath), content: { resImg in
                resImg
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170, height: 255)
                    .cornerRadius(15)
                    .shadow(color: .secondary, radius: 10)
            }, placeholder: {
                Image(systemName: "film")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170, height: 255)
                    .foregroundColor(.secondary)
                    .background(.background)
            })
        }
    }
}


#Preview {
    View_Home()
        .environmentObject(MediaViewModel())
}
