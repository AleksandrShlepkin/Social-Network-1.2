
import Foundation
import RealmSwift
import DynamicJSON


class FriendsModel :BaseModel {
    @objc dynamic var userID:  String?
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var photo: String?
    
    convenience required init(data: JSON) {
        self.init()
        
        self.userID = data.id.string
        self.firstName = data.first_name.string
        self.lastName = data.last_name.string
        self.photo = data.photo_100.string
    }
    
    
}



