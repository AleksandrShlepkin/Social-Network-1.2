//
//  GroupsAPI.swift
//  Social Network
//
//  Created by Alex on 24.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class GroupsAPI {
    let baseURL = "https://api.vk.com/method"
    let token = Session.shared.token
    let userID = Session.shared.userID
    let version = "5.138"
    
    func getGroups(complection: @escaping (GroupsCodable) -> () ){
        
        let method = "/groups.get"
        let parametrs: Parameters = [
            "user_id": Session.shared.userID,
            "extended": 1,
            "count": 50,
            "access_token": Session.shared.token,
            "v": version
        ]
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parametrs).responseData { response in
            guard let data = response.data else { return }
            let decoder = JSONDecoder()
            let json = JSON(data)
            let dispatch = DispatchGroup()
            
            let JSONItemArray = json["response"]["items"].arrayValue
            
            var itemsArray: [ItemGroups] = []
            
            DispatchQueue.global().async(group: dispatch) { for (index, items) in JSONItemArray.enumerated() {
                do{
                    let decodItem = try decoder.decode(ItemGroups.self, from: items.rawData())
                    itemsArray.append(decodItem)
                } catch {
                    print("\(index) \(error)")
                }
            }
            
            }
            dispatch.notify(queue: DispatchQueue.main) {
                let response = ResponseGroups(count: 50, items: itemsArray)
                let feed = GroupsCodable(response: response)
                complection(feed)
            }
            
        }
    }
    

    
}
