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
    
    
    func getNews(completion: @escaping (NewsCodable?) -> ()) {
        let method = "/newsfeed.get"
        
        let parametrs: Parameters =
            [
                "user_id": Session.shared.userID,
                "filters" : "post",
                "count" : 50,
                "access_token": Session.shared.token,
                "v": "5.131"
            ]
        let url = baseURl + method
        
        AF.request(url, method: .get, parameters: parametrs).responseData { respons in
                            
            guard let data = respons.data else { return }
            print(data.prettyJSON)

            let decoder = JSONDecoder()
            let json = JSON(data)
            let dispatch = DispatchGroup()

            let JSONItemsArray = json["response"]["items"].arrayValue
            let JSONProfilesArray = json["response"]["profiles"].arrayValue
            let JSONGroupsArray = json["response"]["groups"].arrayValue

            var itemArray: [Item] = []
            var groupArray: [Group] = []
            var profileArray: [Profile] = []
            
            
            DispatchQueue.global().async(group: dispatch) {
                for (index, items) in  JSONItemsArray.enumerated(){
                    do {
                        let decodItem = try decoder.decode(Item.self, from: items.rawData() )
                        itemArray.append(decodItem)
                    } catch {
                        print("\(index) \(error)")
                    }
                }
            }
            
            DispatchQueue.global().async(group: dispatch) {
                for (index, profile) in JSONProfilesArray.enumerated() {
                    do {
                        let decodProfile = try decoder.decode(Profile.self, from: profile.rawData())
                        profileArray.append(decodProfile)
                    } catch {
                        print("\(index) \(error)")
                    }
                }
            }
            
            DispatchQueue.global().async(group: dispatch) {
                for (index, groups) in JSONGroupsArray.enumerated() {
                    do {
                        let decodGroup = try decoder.decode(Group.self, from: groups.rawData())
                        groupArray.append(decodGroup)
                    } catch {
                        print("\(index) \(error)")
                    }
                }
            }
            
            dispatch.notify(queue: DispatchQueue.main){
                let respons = Response(items: itemArray, groups: groupArray, profiles: profileArray)
                let feed = NewsCodable(response: respons)
                completion(feed)
            }
           
        }
    }

    
    
    }
