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
    let backdropPath: String
    let posterPath: String
    let firstAirDate, releaseDate: String?
}
