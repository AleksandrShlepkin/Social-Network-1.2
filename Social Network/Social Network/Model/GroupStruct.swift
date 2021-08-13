//
//  GroupStruct.swift
//  Social Network
//
//  Created by Alex on 28.06.2021.
//

import Foundation
import RealmSwift
import  DynamicJSON
import Firebase

class GroupsModel: BaseModel {
    
    @objc dynamic var groupID: String?
    @objc dynamic var photo: String?
    @objc dynamic var name: String?
    
    convenience required init(data: JSON) {
        self.init()
        self.groupID = data.id.string
        self.photo = data.photo_100.string
        self.name = data.name.string
        
    }
}
class FireBaseGroupsModel {
    let id: String
    let ref: DatabaseReference?
    init(id: String){
        self.ref = nil
        self.id = id
    }
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String : Any],
              let id = value["id"] as? String
        else { return nil }
        self.ref = snapshot.ref
        self.id = id
    }
    func toAnyObject() -> [String : Any] {
        return ["id" : id]
    }
}
