//
//  SearchResult.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [ApiResult]
}

struct ApiResult: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}
