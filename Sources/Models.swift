//
//  Models.swift
//
//
//  Created by Alireza on 11/12/21.
//

import Foundation

struct SimilarShows: Codable {
    let recommendations: [TVShow]
    let trending_shows: Bool
}

public struct TVShow: Codable {
    public let name: String
    public let weight, id: Int
}
