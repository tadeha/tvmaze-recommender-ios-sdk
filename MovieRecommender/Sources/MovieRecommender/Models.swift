//
//  File.swift
//  
//
//  Created by Alireza on 11/12/21.
//

import Foundation

struct SimilarShows: Codable {
    let similarShow: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case similarShow = "similar_show"
    }
}

public struct TVShow: Codable {
    public let id, name: String
}
