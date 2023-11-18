//
//  MediaViewModel.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-17.
//

import Foundation

final class MediaViewModel: ObservableObject {
    
    private let API_KEY = "66683917a94e703e14ca150023f4ea7c"
    
    @Published var mediaLibrary: [MediaItem] = []
    @Published private(set) var isRefreshing = false
    
    @MainActor
    func fetchData(mediaType: String = "movie") async throws  {
                
        let mediaUrlString = "https://api.themoviedb.org/3/\(mediaType)/popular?api_key=\(API_KEY)"
        
        if let url = URL(string: mediaUrlString) {
            isRefreshing = true
            defer { isRefreshing = false }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)

                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 299 else {
                    throw FetchError.invalidStatusCode
                }
                
                /*Delay for spinner*/ try await Task.sleep(nanoseconds: 500_000_000)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let apiRes = try? decoder.decode(APIRes.self, from: data) else {
                    throw FetchError.failedToDecode
                }
                self.mediaLibrary = apiRes.results
                
            } catch {
                throw FetchError.custom(error: error)
            }
        }
    }
}

extension MediaViewModel {
    enum FetchError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            case .invalidStatusCode:
                return "Invalid status code"
            }
        }
    }
}
