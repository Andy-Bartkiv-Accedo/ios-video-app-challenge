//
//  DropDownView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-30.
//

import SwiftUI

struct SortingDropDownMenu: View {
    var content: [String]
    @Binding var selection: String
    
    @EnvironmentObject private var mvm: MediaViewModel

    var body: some View {
        Picker("Sort", selection: $selection) {
            ForEach(content, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.menu)
        .tint(.primary)
        .frame(width: 90, height: 35)
        .background(Color.accentColor.opacity(0.75))
        .cornerRadius(10)
        .onChange(of: selection, {
            withAnimation {
                mvm.sortLibrary(prop: selection)
            }
        })
    }
}

//#Preview {
//    SortingDropDownMenu()
//}
