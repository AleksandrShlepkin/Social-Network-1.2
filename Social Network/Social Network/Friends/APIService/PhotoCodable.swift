//
//  PhotoCodable.swift
//  Social Network
//
//  Created by Alex on 29.08.2021.
//

import Foundation


// MARK: - PhotoCodable
struct PhotoCodable: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [ItemPhoto]
}

// MARK: - Item
struct ItemPhoto: Codable {
    let albumID: Int
    let sizes: [SizePhoto]
    let postID, id, date: Int
    let text: String
    let lat: Double?
    let hasTags: Bool
    let ownerID: Int
    let long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case sizes
        case postID = "post_id"
        case id, date, text, lat
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case long
    }
}

// MARK: - Size
struct SizePhoto: Codable {
    let width, height: Int
    let url: String
    let type: TypeEnumPhoto
}

enum TypeEnumPhoto: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
