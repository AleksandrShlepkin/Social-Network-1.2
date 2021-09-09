//
//  NewsAPI.swift
//  Social Network
//
//  Created by Alex on 22.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class NewsAPI {
    
    let baseURl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userID = Session.shared.userID
    let version = "5.138"
  
    
    
    func getNews(startTime: Double? = nil, nextFrom: String = "", completion: @escaping (NewsCodable?) -> ()) {
        
        var parametrs: Parameters =
                [
                    "client_id" : Session.shared.userID,
                    "user_id": Session.shared.clientID,
                    "filters" : "post",
                    "count" : 20,
                    "access_token": Session.shared.token,
                    "v": "5.131",
                    "start_from": nextFrom
                    
                ]
        if let startTime = startTime {
            parametrs["start_time"] = startTime 
        }
        let method = "/newsfeed.get"
        
        let url = baseURl + method
        
        AF.request(url, method: .get, parameters: parametrs).responseData { respons in
            
            guard let data = respons.data else { return }
            print(data.prettyJSON as Any)
            let decoder = JSONDecoder()
            let json = JSON(data)
            
            let nextFrom = json["respons"]["next_from"].stringValue

//            let dispatch = DispatchGroup()
//
//            let JSONItemsArray = json["response"]["items"].arrayValue
//            let JSONProfilesArray = json["response"]["profiles"].arrayValue
//            let JSONGroupsArray = json["response"]["groups"].arrayValue
//
//
//            var itemArray: [Item] = []
//            var groupArray: [Group] = []
//            var profileArray: [Profile] = []
            
            DispatchQueue.main.async {
            AF.request(url, method: .get, parameters: parametrs).responseData { response in
                guard let data = response.data else { return }
                do {
                    var newsItems: NewsCodable
                    
                    newsItems = try decoder.decode(NewsCodable.self, from: data)
                    completion(newsItems)
                    
                } catch {
                    print(error)
                }
            }
//                        DispatchQueue.global().async(group: dispatch) {
//                            for (index, items) in  JSONItemsArray.enumerated(){
//                                do {
//                                    let decodItem = try decoder.decode(Item.self, from: items.rawData() )
//                                    itemArray.append(decodItem)
//                                } catch {
//                                    print("\(index) \(error)")
//                                }
//                            }
//                        }
//
//                        DispatchQueue.global().async(group: dispatch) {
//                            for (index, profile) in JSONProfilesArray.enumerated() {
//                                do {
//                                    let decodProfile = try decoder.decode(Profile.self, from: profile.rawData())
//                                    profileArray.append(decodProfile)
//                                } catch {
//                                    print("\(index) \(error)")
//                                }
//                            }
//                        }
//
//                        DispatchQueue.global().async(group: dispatch) {
//                            for (index, groups) in JSONGroupsArray.enumerated() {
//                                do {
//                                    let decodGroup = try decoder.decode(Group.self, from: groups.rawData())
//                                    groupArray.append(decodGroup)
//                                } catch {
//                                    print("\(index) \(error)")
//                                }
//                            }
//                        }
//
//            dispatch.notify(queue: DispatchQueue.main){
//                let respons = Response(items: itemArray, groups: groupArray, profiles: profileArray, nextFrom: nextFrom)
//                let feed = NewsCodable(response: respons)
//                completion(feed)
//            }
//
//        }
    }
    
    
    
}
    }
}
