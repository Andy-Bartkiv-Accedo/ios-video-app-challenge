//
//  YTButtonView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-12-11.
//

import WebKit
import SwiftUI

struct YTButtonView: View {
    var item: MediaItem
    private let clientTrailer = KinocheckHTTPClient()
    
    @State var videoId: String = "nAchMctX4YA"

    var body: some View {
        ZStack {
            Image(systemName: videoId == "nAchMctX4YA"
                  ? "play.circle"
                  : "play.fill")
                .frame(width: 365, height: 65)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .background(Color.teal)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            Video(videoId: videoId)
                .frame(width: 365, height: 65)
                .cornerRadius(10)
                .opacity(0.02)
            }
        .task {
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
    YTButtonView(item: dummyItem)
}
