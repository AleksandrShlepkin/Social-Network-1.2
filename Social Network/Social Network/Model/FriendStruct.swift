
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

protocol RealmServiceProtocol {
    func add(user: FriendsModel)
    func read() -> [FriendsModel]
    func delete(user: FriendsModel)
}

class RealmService: RealmServiceProtocol {
    
    let config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    func add(user: FriendsModel) {
        do {
            self.realm.beginWrite()
            self.realm.add(user)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    func read() -> [FriendsModel] {
        let user = realm.objects(FriendsModel.self)
        return Array(user)
    }
    func delete(user: FriendsModel){
        do {
            self.realm.beginWrite()
            self.realm.delete(user)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
        
    }
}



