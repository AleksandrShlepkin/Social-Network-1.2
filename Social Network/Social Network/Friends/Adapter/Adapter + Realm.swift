//
//  Adapter + Realm.swift
//  Social Network
//
//  Created by Alex on 29.09.2021.
//

import Foundation
import RealmSwift

//class FriendsAdapter {
//    private let friendsService = FriendsAPI()
//    private var realmNotification: [String: NotificationToken] = [:]
//    
//    
//    func getFriends(to friends: String, completion: @escaping ([Friends]) -> Void){
//        guard let realm = try? Realm(),
//              let realmFriend = realm.object(ofType: FriendsModelRealm.self, forPrimaryKey: friends) else { return }
//        //MARK: Не понимаю в чем проблема, что не так с realm
//        
//        realmNotification[friends].stop()
//        
//        let token = realmFriend.friends.observe { (changes) in
//            switch changes {
//            case .initial:
//                break
//            case .update(let realmFriends, _, _,_ ):
//                let friends: [Friends] = realmFriends.map { (friendsModel) -> Friends in
//                    
//                    //MARK: Здесь такая же проблема, я не могу понять что не так, вроде преобразую все как на уроке, из realm объектов в обычную структуру
//                    
//                    return self.getFriends(from: friendsModel)
//                }
//                completion(friends)
//            case .error(let error):
//                print(error)
//                
//                
//            }
//        }
//        realmNotification[friends] = token
//        
//    }
//    
//    private func getFriends(from realmFriends: FriendsModelRealm) -> Friends {
//        Friends(firstName: realmFriends.name ?? "",
//                id: realmFriends.id ?? "")
//    }
//
//
//}
