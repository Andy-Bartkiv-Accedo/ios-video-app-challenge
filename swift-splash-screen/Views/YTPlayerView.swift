//
//  YTPlayerView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-12-04.
//

import WebKit
import SwiftUI

struct YTPlayerView: View {
    let videoId: String

    var body: some View {
        Video(videoId: videoId)
            .frame(height:220)
            .border(Color.orange, width: 5)
            .cornerRadius(10)
    }
}

struct Video: UIViewRepresentable{
    
    let videoId: String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let YouTubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: YouTubeURL))
    }
}

#Preview {
    YTPlayerView(videoId: "CvWLK9TvvdI")
}
