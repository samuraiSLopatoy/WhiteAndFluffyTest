//
//  Photo.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//

import Foundation

struct SearchResults: Decodable {
    let results: [Photo]
}

struct Photo: Decodable {
    let id: String
    let created_at: String
    let urls: Urls
    let user: User
    let downloads: Int?
}

struct Urls: Decodable {
    let raw, full, regular, small, thumb: String
}

struct User: Decodable {
    let name: String
    let location: String?
}
