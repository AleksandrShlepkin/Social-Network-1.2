//
//  PhotoAPI.swift
//  Social Network
//
//  Created by Alex on 30.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class PhotoAPI {
    let baseURL = "https://api.vk.com/method"
    let version = "5.138"
    
    
    
    func getPhoto( completion: @escaping (PhotoCodable?) -> ()){
        let method = "/photos.get"
        let parametrs: Parameters =
            [
                "album_id": "profile",
                "rev": 1,
                "count": 30,
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
            var itemsArray: [ItemPhoto] = []
            
            DispatchQueue.global().async(group: dispatch) { for (index, items) in JSONItemsArray.enumerated() {
                do {
                    let decodItem = try decoder.decode(ItemPhoto.self, from: items.rawData())
                    itemsArray.append(decodItem)
                } catch {
                    print("\(index) \(error)")
                }
            }
            }
            dispatch.notify(queue: DispatchQueue.main) {
                let response = ResponsePhoto(count: 50, items: itemsArray)
                let feed = PhotoCodable(response: response)
                completion(feed)
                
            }
            
        }
    }
}
