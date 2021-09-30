//
//  BaseModel.swift
//  Social Network
//
//  Created by Alex on 05.07.2021.
//

import Foundation
import RealmSwift
import DynamicJSON


public class BaseModel: Object {
    
    @objc dynamic var run = ""
    
     convenience required init(data: JSON) {
       self.init()
    }
    
}
