//
//  UserModel.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-12-14.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let password: String
    let avatar: String
    let favorites: [Int]
}
