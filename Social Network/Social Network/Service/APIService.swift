//
//  APIService.swift
//  Social Network
//
//  Created by Alex on 24.06.2021.
//

import Foundation
import Alamofire
import DynamicJSON
import Firebase
import SwiftyJSON

final class APIService {
    
    let baseURl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userID = Session.shared.userID
    let version = "5.138"
    
    func getGroup (completion: @escaping ([GroupsModel]) -> Void ){
        let method = "/groups.get"
        
        let param: Parameters =
            [
                "user_id": Session.shared.userID,
                "extended": 1,
                "count": 30,
                "access_token": Session.shared.token,
                "v": version
            ]
        let url = baseURl + method
        
        AF.request(url, method: .get, parameters: param).responseData { (response) in
            guard let data = response.data else { return }
//            print(data.prettyJSON as Any)
            guard let items = JSON(data).response.items.array else { return }
            let groups = items.map { GroupsModel(data: $0)}
            DispatchQueue.main.async {
                completion(groups)
            }    }
    }
    
    func getFriend (completion: @escaping ([FriendsModel]) -> ()){
        let method = "/friends.get"
        
        let parameters: Parameters =
            [
                "user_id": Session.shared.userID,
                "order": "name",
                "count": 72,
                "fields": ["photo_100", "online"],
                "access_token": Session.shared.token,
                "v": version
            ]
        let url = baseURl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData {  response in
            
            guard let data = response.data else { return}
            print(data.prettyJSON as Any)
            guard let items = JSON(data).response.items.array else { return }
            let friends = items.map { FriendsModel(data: $0) }
            DispatchQueue.main.async {
                completion(friends)
            }
        }
    }
    
    func getPhoto (completion: @escaping ([PhotoModel]) -> ()) {
        let method = "/photos.get"
        
        let param: Parameters =
            [
                "album_id": "profile",
                "rev": 1,
                "count": 30,
                "access_token": Session.shared.token,
                "v": version
            ]
        let url = baseURl + method
        AF.request(url, method: .get, parameters: param).responseData { response in
            guard let data = response.data else { return}
//            print(data.prettyJSON as Any)
            guard let items = JSON(data).response.item.array else { return }
            let photos = items.map { PhotoModel(data: $0)}
            
            DispatchQueue.main.async {
                print(photos)
            }
        }
    }


}
