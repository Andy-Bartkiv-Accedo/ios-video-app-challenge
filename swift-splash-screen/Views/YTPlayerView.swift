//
//  YTPlayerView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-12-04.
//

import WebKit
import SwiftUI

struct YTPlayerView: View {
    var item: MediaItem
    private let clientTrailer = KinocheckHTTPClient()
    
    @EnvironmentObject private var mvm: MediaViewModel
    @State private(set) var isFetchingId = false
    @State var videoId: String = ""

    var body: some View {
        ZStack {
            if isFetchingId || videoId == "" {
                ItemImage(imgUrl: item.backdropPath ?? "")
                    .frame(height:220)
                    .cornerRadius(10)
            } else {
                Video(videoId: videoId)
                    .background(Color.black)
                    .frame(height:220)
                    .cornerRadius(10)
            }
        }
        .task {
            isFetchingId = true
            defer { isFetchingId = false }
            do {
                videoId = try await clientTrailer.fetchTrailerId(
                    mediaType: item.type ?? "", id: String(item.id)
                )
            } catch { print("Error:", error.localizedDescription) }
        }
    }
}

struct Video: UIViewRepresentable{
    
    let videoId: String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        print("https://www.youtube.com/embed/\(videoId)")
        guard let YouTubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: YouTubeURL))
    }
}

#Preview {
    YTPlayerView(item: dummyItem)
}
