//
//  File.swift
//  Social Network
//
//  Created by Alex on 27.08.2021.
//

import Foundation

//MARK: Получение API friends.get
class FriendsAPIOperation: Operation {
    
    var data: Data?
    
    override func main() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: Session.shared.userID),
            URLQueryItem(name: "fields", value: "sex, online, bdate, photo_100, status"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.138"),
        ]
        guard let url = components.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
        
    }
}


// MARK: Парсинг данных полученных из API
class ParsingFriends: Operation{
    
    var friendsItems: [ItemFriends]? = []
    override func main() {
        guard let friendsDATA = dependencies.first as? FriendsAPIOperation,
              let data = friendsDATA.data else { return }
        
        do {
            var friends: FriendsCodable
            friends = try JSONDecoder().decode(FriendsCodable.self, from: data)
            self.friendsItems = friends.response.items
            print(data.prettyJSON as Any)
        } catch {
            print(error)
        }
    }
}

