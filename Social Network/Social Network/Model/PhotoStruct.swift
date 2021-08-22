//
//  PhotoStruct.swift
//  Social Network
//
//  Created by Alex on 01.07.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

var idFriend: FriendsModel?

class PhotoModel: BaseModel {
    @objc dynamic var id = idFriend?.userID
    @objc dynamic var photoID: String?
    @objc dynamic var photo100: String?
    
    convenience required init (data: JSON) {
        self.init()
        
        self.photoID = data.id.string
        self.photo100 = data.photo_100.string
    }
    
}


