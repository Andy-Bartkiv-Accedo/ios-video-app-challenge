//
//  FilterSortSelectorsTopBarView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-30.
//

import SwiftUI

struct FilterSortSelectorsTopBar: View {
    @State private var selectedFilter: String = ""
    @State private var selectedSort: String = "Views"

    var body: some View {
        VStack {
            HStack {
                FilterTag(label: "Favorite", selectedFilter: $selectedFilter, selectedSort: $selectedSort)
                FilterTag(label: "Movies", selectedFilter: $selectedFilter, selectedSort: $selectedSort)
                FilterTag(label: "Shows", selectedFilter: $selectedFilter, selectedSort: $selectedSort)
                SortingDropDownMenu(
                    content: ["Views", "Title", "Year", "Votes"],
                    selection: $selectedSort)
            }
            .frame(height: 20, alignment: .top)
            Spacer()
        }
    }
}

#Preview {
    FilterSortSelectorsTopBar()
}
