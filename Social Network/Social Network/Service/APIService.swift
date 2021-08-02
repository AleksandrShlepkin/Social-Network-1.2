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

final class APIService {
    
    let baseURl = "https://api.vk.com/method"
    let token = Session.shared.token1
    let userID = Session.shared.userID
    let version = "5.138"
    
    func getGroup (completion: @escaping ([GroupsModel]) -> Void ){
        let method = "/groups.get"
        
        let param: Parameters =
            [
                "user_id": Session.shared.userID,
                "extended": 1,
                "count": 30,
                "access_token": Session.shared.token1,
                "v": version
            ]
        let url = baseURl + method
        
        AF.request(url, method: .get, parameters: param).responseData { (response) in
            guard let data = response.data else { return }
            print(data.prettyJSON as Any)
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
                "count": 30,
                "fields": "photo_100",
                "access_token": Session.shared.token1,
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
    
    func getPhoto (completion: @escaping ([Photo]) -> ()) {
        let method = "/photos.get"
        
        let param: Parameters =
            [
                "album_id": "profile",
                "rev": 1,
                "count": 30,
                "access_token": Session.shared.token1,
                "v": version
            ]
        let url = baseURl + method
        AF.request(url, method: .get, parameters: param).responseData { response in
            guard let data = response.data else { return}
            print(data.prettyJSON as Any)
            guard let items = JSON(data).response.item.array else { return }
            let photos = items.map { PhotoModel(data: $0)}
            
            DispatchQueue.main.async {
                print(photos)
            }
        }
    }
    
    
    func getNews(completion: @escaping ([NewsSecond]) -> () ){
        let method = "/newsfeed.get"
        let ref = Database.database().reference(withPath: "News")
        let param: Parameters =
            [
                "filters" : "post",
                "count" : 30,
                "access_token" : Session.shared.token1,
                "v": version
            ]
        let url = baseURl + method
        AF.request(url, method: .get, parameters: param).responseData { respons in
            guard let data = respons.data else { return }
            print(data.prettyJSON as Any)
            guard let items = JSON(data).response.item.array else { return }
            let news = items.map{ NewsSecond(data: $0)
            }
            DispatchQueue.main.async {
                completion(news)
            }
                        
            for news in items {
                let new = News(data: news)
                let newRef = ref.child(Session.shared.userID).child(String(new.postId))
                newRef.setValue(new.toAnyObject())
            }
        }
    }
    
    func getNewsfeed() {
        let method = "/newsfeed.get"
        let ref = Database.database().reference(withPath: "news")
        
        let parameters: Parameters = [
            "filters": "post",
            //"return_banned": ,
            //"start_time": ,
            //"end_time": ,
            //"max_photos": ,
            //"source_ids": ,
            //"start_from": ,
            "count": "10",
            //"fields": ,
            //"section": ,
            "access_token": Session.shared.token1,
            "v": version
        ]
        
        let url = baseURl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            guard let items = JSON(data).response.items.array else { return }
            
            for new in items {
                let new = News(data: new)
                let newRef = ref.child(Session.shared.userID).child(String(new.postId))
                newRef.setValue(new.toAnyObject())
            }
        }
    }

}
