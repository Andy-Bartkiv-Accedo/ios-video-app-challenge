//
//  ContentView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject private var mvm: MediaViewModel
    @EnvironmentObject private var avm: AuthViewModel

    var body: some View {
        
        TabView {
            View_Home()
                .tabItem() {
                    Image(systemName: "film.stack")
                    Text("Home")
                }
                .environmentObject(mvm)
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
                .environmentObject(avm)
                .environmentObject(mvm)
        }
        
        .task {
            await mvm.fetchAllData()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MediaViewModel())
        .environmentObject(AuthViewModel())
}
