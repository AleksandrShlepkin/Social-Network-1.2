//
//  FriendModelForRealm.swift
//  Social Network
//
//  Created by Alex on 30.09.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

class FriendsModelRealm: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    
    let friends = List<FriendsModel>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}

class FriendsModel :Object {
    @objc dynamic var userID:  String?
    @objc dynamic var firstName: String?
 
   
    convenience required init(data: JSON) {
        self.init()
        
        self.userID = data.id.string
        self.firstName = data.first_name.string
    }
}

struct Friends {
    let firstName: String
    let id: String
}
