//
//  KinocheckHTTPClient.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-12-04.
//

import Foundation

struct KinocheckHTTPClient {
    
    func fetchTrailerId(mediaType: String, id: String) async throws -> String {
        let type = mediaType == "movie"
            ? "movies"
            : "shows"
        let mediaUrlString = "https://api.kinocheck.de/\(type)?tmdb_id=\(id)"
        if let url = URL(string: mediaUrlString) {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw FetchError.invalidResponse
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let apiRes = try? decoder.decode(KinocheckAPIRes.self, from: data) else {
                throw FetchError.decodingError
            }
            return apiRes.trailer.youtubeVideoId
        } else {
            return ""
        }
    }
    
    enum FetchError: Error {
        case badUrl
        case invalidResponse
        case decodingError
        case invalidServerResponse
        case invalidUrl
    }
}

