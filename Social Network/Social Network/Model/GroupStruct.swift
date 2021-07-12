//
//  GroupStruct.swift
//  Social Network
//
//  Created by Alex on 28.06.2021.
//

import Foundation
import RealmSwift
import  DynamicJSON

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
