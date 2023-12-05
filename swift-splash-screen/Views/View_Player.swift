//
//  View_Player.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import AVKit
import SwiftUI

struct View_Player: View {

    private let player = AVPlayer(url: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!)
    
    var body: some View {
//        VideoPlayer(player: player)
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
