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
    let trailer: Trailer
}

struct Trailer: Codable {
    let youtubeVideoId: String
}
