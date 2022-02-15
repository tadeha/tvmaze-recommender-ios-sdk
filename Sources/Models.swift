//
//  Models.swift
//
//
//  Created by Alireza on 11/12/21.
//

import Foundation

struct SimilarShows: Codable {
    let recommendations: [String: String]
}

public struct TVShow: Codable {
    public let id, name: String
}
