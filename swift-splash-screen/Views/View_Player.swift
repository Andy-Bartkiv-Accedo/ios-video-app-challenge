//
//  View-Series.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_Player: View {
    var body: some View {
        ZStack{
            Color.teal
                .edgesIgnoringSafeArea(.top)

            Image(systemName: "film")
                .foregroundColor(.orange)
                .opacity(0.65)
                .font(.system(size: 200.0))
        }
    }
}

#Preview {
    View_Player()
}
