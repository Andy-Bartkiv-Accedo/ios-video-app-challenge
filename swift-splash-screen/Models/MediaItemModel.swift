//
//  MediaItemModel.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-17.
//

import Foundation

struct APIRes: Codable {
    let results: [MediaItem]
}

struct MediaItem: Codable {
    let id: Int
    let name, title: String?
    let overview: String
    let backdropPath: String?
    let posterPath: String
    let firstAirDate, releaseDate: String?
    let popularity: Float?
    let voteAverage: Float?
    let voteCount: Int?
    
    var type: String?
    var favorite: Bool? = false
    var trailerId: String? = ""
}

struct KinocheckAPIRes: Codable {
//    let id: String
//    let tmdbID: Int
//    let imdbID, language, title: String
//    let url: String
    let trailer: Trailer
//    let videos: [Trailer]
}

// MARK: - Trailer
struct Trailer: Codable {
    let id, youtubeVideoId, youtubeChannelID: String
//    let youtubeThumbnail: String
//    let title: String
//    let thumbnail: String
//    let language: String
//    let categories: [String]
//    let published: Date
//    let views: Int
}
