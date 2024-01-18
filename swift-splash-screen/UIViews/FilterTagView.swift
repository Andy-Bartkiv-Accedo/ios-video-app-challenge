//
//  FilterTagView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-30.
//

import SwiftUI

struct FilterTag: View {
    var label: String
    @Binding var selectedFilter: String
    @Binding var selectedSort: String
    
    @EnvironmentObject private var mvm: MediaViewModel
    
    var body: some View {
        Text(label)
            .frame(width: 85, height: 35)
            .font(.system(size: 20))
            .foregroundColor(.primary)
            .background(selectedFilter == label
                        ? Color.orange.opacity(0.75)
                        : Color.accentColor.opacity(0.75))
            .cornerRadius(10)
            .shadow(color: .secondary, radius: 10)
            .bold()
            .padding(.horizontal, 2.5)
            .onTapGesture {
                withAnimation {
                    if selectedFilter == label {
                        selectedFilter = ""
                        mvm.updateLibrary()
                    } else {
                        selectedFilter = label
                        switch label {
                        case "Favorite":
                            mvm.filterFavourites()
                        case "Movies":
                            mvm.filterLibrary(mediaType: "movie")
                        case "Shows":
                            mvm.filterLibrary(mediaType: "tv")
                        case "-Sort-":
                            mvm.sortLibrary(prop: "vote")
                        default: break
                        }
                        mvm.sortLibrary(prop: selectedSort)
                    }
                }
            }
    }
}

//#Preview {
//    FilterTag()
//}
