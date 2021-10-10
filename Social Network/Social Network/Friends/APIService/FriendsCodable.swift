// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let friendsCodable = try? newJSONDecoder().decode(FriendsCodable.self, from: jsonData)

import Foundation

// MARK: - FriendsCodable
struct FriendsCodable: Codable {
    let response: ResponseFriends
}

// MARK: - Response
struct ResponseFriends: Codable {
    let count: Int
    let items: [ItemFriends]
}

// MARK: - Item
struct ItemFriends: Codable {
    let canAccessClosed: Bool?
    let online, id: Int
    let photo100: String
    let lastName, trackCode: String?
    let isClosed: Bool?
    let firstName: String
    let lists: [Int]?
    let deactivated: String?
    let bdate: String?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
        case lists, deactivated
        case bdate = "bdate"
    }
}
