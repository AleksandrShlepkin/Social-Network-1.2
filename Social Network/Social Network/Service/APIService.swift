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
    

    
    func getPhoto (completion: @escaping ([PhotoModel]) -> ()) {
        let method = "/photos.get"
        
        let param: Parameters =
            [
                "owner_id": Session.shared.userID,
                "album_id": "profile",
                "rev": 1,
                "count": 30,
                "access_token": Session.shared.token,
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


}
