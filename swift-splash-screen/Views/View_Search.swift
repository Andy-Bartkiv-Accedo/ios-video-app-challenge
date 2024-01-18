//
//  View_Search.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Search: View {
    
    @EnvironmentObject private var mvm: MediaViewModel
    
    private var adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    @State private var search = ""
    @State private var results = false

    var body: some View {
        NavigationView {
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
                    if !results {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.teal)
                            .font(.system(size: 75.0))
                    }
                    
                    HStack {
                        if results {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 30.0))
                                .onTapGesture {
                                    withAnimation {
                                        search = ""
                                        results = false
                                    }
                                }
                        }
                        
                        TextField("Search...", text: $search)
                            .fontWeight(.bold)
                            .frame(width: 300, height: 50)
                            .background()
                            .cornerRadius(10)
                        
                        if results {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .font(.system(size: 30.0))
                                .onTapGesture {
                                    withAnimation {
                                        mvm.searchLibrary(query: search)
                                    }
                                }
                        }
                    }
                    
                    if !results {
                        Button("Explore") {
                            if search.count > 0 {
                                mvm.searchLibrary(query: search)
                                withAnimation {
                                    results = !results
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 25.0))
                        .frame(width: 300, height: 50)
                        .background(Color.teal.opacity(0.75))
                        .cornerRadius(10)
                    }
                    
                    if results {
                        ZStack {
                            Color.black.opacity(0.75)
                            
                            if mvm.searchResults.count == 0 {
                                Text("No match found for your search")
                                    .font(.system(size: 25.0))
                            }
                            
                            ScrollView {
                                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                                    ForEach(mvm.searchResults, id: \.id) { mediaItem in
                                        ItemPoster(item: mediaItem)
                                    }
                                }
                                .offset(x:0, y:20)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    View_Search()
        .environmentObject(MediaViewModel())
}
