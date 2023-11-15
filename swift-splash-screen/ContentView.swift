//
//  ContentView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            View_Home()
                .tabItem() {
                    Image(systemName: "film.stack")
                    Text("Home")
                }
            View_Search()
                .tabItem() {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            View_User()
                .tabItem() {
                    Image(systemName: "person.fill")
                    Text("My Account")
                }
        }
    }
}

#Preview {
    ContentView()
}
