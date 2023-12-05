//
//  MediaHTTPClient.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-29.
//

import Foundation

class MediaHTTPClient {
    
    private let API_KEY = "66683917a94e703e14ca150023f4ea7c"
    
    func fetchPopularByType(mediaType: String) async throws -> [MediaItem] {
        let mediaUrlString = "https://api.themoviedb.org/3/\(mediaType)/popular?api_key=\(API_KEY)"
        if let url = URL(string: mediaUrlString) {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw FetchError.invalidResponse
            }
            /*Delay for spinner*/ try await Task.sleep(nanoseconds: 500_000_000)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let apiRes = try? decoder.decode(APIRes.self, from: data) else {
                throw FetchError.decodingError
            }
            var mediaItems: [MediaItem] = apiRes.results
            for index in mediaItems.indices {
                mediaItems[index].type = mediaType
            }
            return mediaItems
            
        } else {
            return []
        }
    }
}

enum FetchError: Error {
    case badUrl
    case invalidResponse
    case decodingError
    case invalidServerResponse
    case invalidUrl
}
