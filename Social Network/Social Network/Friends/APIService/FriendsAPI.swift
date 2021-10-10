//
//  FriendsAPI.swift
//  Social Network
//
//  Created by Alex on 23.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GetFriends{
    func getFriends(completion: @escaping ([ItemFriends]) -> ())
}


class FriendsAPI: GetFriends {
    let baseURL = "https://api.vk.com/method"
    let token = Session.shared.token
    let userID = Session.shared.userID
    let version = "5.138"
    
    
    func getFriends(completion: @escaping ([ItemFriends]) -> ()) {
        
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
            do {
            let friendResponder = try JSONDecoder().decode(FriendsCodable.self, from: data)
            let friends = friendResponder.response.items

            DispatchQueue.main.async {
                completion(friends)
                print("Proxy has not finished working")
            }
            } catch {
                print(error)
        }


        }
    }
}

class ProxyFriendsAPI: GetFriends {
    
    
    
    var friendsAPI: FriendsAPI
    
    init(friendsAPI: FriendsAPI){
        self.friendsAPI = friendsAPI
    }

    
    func getFriends(completion: @escaping ([ItemFriends]) -> ()) {
        let method = "/friends.get"
        let baseURL = friendsAPI.baseURL
        let url = baseURL + method
        
        let parametrs: Parameters = [
            "user_id": Session.shared.userID,
            "fields": ["photo_100", "online", "bdate"],
            "count": 72,
            "access_token": Session.shared.token,
            "v": "5.138"
        ]

        AF.request(url, method: .get, parameters: parametrs).responseData {  response in
            
            
            guard let data = response.data else { return}
            do {
            let friendResponder = try JSONDecoder().decode(FriendsCodable.self, from: data)
            let friends = friendResponder.response.items
            DispatchQueue.main.async {
                completion(friends)
                print("Proxy has finished working")
            }
            } catch {
                print(error)
        }
        }
    }
        
}

