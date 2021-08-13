// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsCodable = try? newJSONDecoder().decode(NewsCodable.self, from: jsonData)

import Foundation

// MARK: - NewsCodable
struct NewsCodable: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let items: [Item]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let isMember, id: Int?
    let photo100: String?
    let isAdvertiser, isAdmin: Int?
    let photo50, photo200: String?
    let type, screenName, name: String?
    let isClosed: Int?

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

// MARK: - Item
struct Item: Codable {
    let donut: Donut?
    let comments: Comments
    let canSetCategory, isFavorite: Bool?
    let shortTextRate: Double?
    let likes: Likes
    let reposts: Reposts
    let type, postType: String?
    let carouselOffset: Int?
    let date: TimeInterval
    let sourceID: Int
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [Attachment]?
    let markedAsAds, postID: Int
    let postSource: PostSource
    let views: Views?
    let signerID: Int?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case carouselOffset = "carousel_offset"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views
        case signerID = "signer_id"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: Photo?
    let video: Video?
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, id, date: Int
    let text: String?
    let userID: Int?
    let hasTags: Bool
    let ownerID: Int?
    let accessKey: String
    let postID: Int?
    let urlPhoto: Size?
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case postID = "post_id"
        case urlPhoto
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int?
    let url: String?
    let type: TypeEnumPhoto?
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case width, height
        case type
        case url = "url"
        case withPadding = "with_padding"
    }
}

// MARK: - Video
struct Video: Codable {
    let ownerID: Int?
    let title: String?
    let canAdd, duration: Int?
    let image: [Size]
    let isFavorite: Bool?
    let views, videoRepeat: Int?
    let type: String?
    let canLike, canComment: Int?
    let firstFrame: [Size]?
    let date, id, height: Int?
    let trackCode: String?
    let width, canAddToFaves: Int?
    let accessKey: String?
    let comments, canSubscribe, canRepost: Int?
    let videoDescription: String?

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case canAdd = "can_add"
        case duration, image
        case isFavorite = "is_favorite"
        case views
        case videoRepeat = "repeat"
        case type
        case canLike = "can_like"
        case canComment = "can_comment"
        case firstFrame = "first_frame"
        case date, id, height
        case trackCode = "track_code"
        case width
        case canAddToFaves = "can_add_to_faves"
        case accessKey = "access_key"
        case comments
        case canSubscribe = "can_subscribe"
        case canRepost = "can_repost"
        case videoDescription = "description"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool?
    let screenName: String?
    let online, id: Int?
    let photo100: String?
    let lastName: String?
    let photo50: String?
    let onlineInfo: OnlineInfo
    let sex: Int?
    let isClosed: Bool?
    let firstName: String?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case lastSeen = "last_seen"
    }
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
