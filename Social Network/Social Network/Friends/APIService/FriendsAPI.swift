//
//  FriendsAPI.swift
//  Social Network
//
//  Created by Alex on 23.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class FriendsAPI {
    let baseURL = "https://api.vk.com/method"
    let token = Session.shared.token
    let userID = Session.shared.userID
    let version = "5.138"
    
    
    func getFriends(completion: @escaping (FriendsCodable?) -> ()) {
        
        let method = "/friends.get"
        let parametrs: Parameters = [
            "user_id": Session.shared.userID,
            "fields": ["photo_100", "online", "bdate"],
            "count": 72,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parametrs).responseData { response in
            guard let data = response.data else { return }
            print(data.prettyJSON as Any)
            let decoder = JSONDecoder()
            let json = JSON(data)
            let dispatch = DispatchGroup()
            
            let JSONItemsArray = json["response"]["items"].arrayValue
            
            var itemsArray:[ItemFriends] = []
            
            DispatchQueue.global().async(group: dispatch) { for (index, items) in JSONItemsArray.enumerated() {
                do{
                    let decodItem = try decoder.decode(ItemFriends.self, from: items.rawData())
                    itemsArray.append(decodItem)
                    print(itemsArray)
                } catch {
                    print("\(index) \(error)")
                }
            }
            }
            dispatch.notify(queue: DispatchQueue.main) {
                let response = ResponseFriends(count: 72, items: itemsArray)
                let feed = FriendsCodable(response: response)
                completion(feed)
            }
        }
    }
}
