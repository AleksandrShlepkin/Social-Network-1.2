// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let groupsCodable = try? newJSONDecoder().decode(GroupsCodable.self, from: jsonData)

import Foundation

// MARK: - GroupsCodable
struct GroupsCodable: Codable {
    let response: ResponseGroups
}

// MARK: - Response
struct ResponseGroups: Codable {
    let count: Int
    let items: [ItemGroups]
}

// MARK: - Item
struct ItemGroups: Codable {
    let isMember, id: Int
    let photo100: String?
    let isAdvertiser, isAdmin: Int?
    let photo50, photo200: String?
    let type: TypeEnum
    let screenName, name: String?
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

enum TypeEnum: String, Codable {
    case group = "group"
    case page = "page"
}
