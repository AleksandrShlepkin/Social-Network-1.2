//
//  GroupProfileViewController.swift
//  Social Network
//
//  Created by Alex on 20.07.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Firebase

class GroupProfileViewController: UIViewController {
    
    let config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    
    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    
    @IBAction func addGroup(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Подписаться", message: "Вы хотите подписаться на обновления?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Подписаться", style: .default, handler: nil)
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        let groupAdd = FireBaseGroupsModel.init(id: profileGroup2?.groupID ?? "")
        let groupRef = self.ref.child(Session.shared.userID).child(profileGroup2?.groupID ?? "")
        groupRef.setValue(groupAdd.toAnyObject())
    }
    
    
    
    var profileGroup2: GroupsModel?
    var realmService: RealmService?
    var apiService: APIService?
    var token: NotificationToken?
    
    let ref = Database.database().reference(withPath: "Groups")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let groupProfile = realmService?.realm.objects(GroupsModel.self)
        self.token = groupProfile?.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let result):
                print(result)
            case let .update(results, deletions, insertions, modifications):
                print(results, deletions, insertions, modifications)
            case .error(let error):
                print(error)
            }
        }
        
        do {
            self.realm.beginWrite()
            self.realm.add(profileGroup2!)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
        
        nameGroup.text = "\(profileGroup2?.name ?? "")"
        imageGroup.sd_setImage(with: URL(string: profileGroup2?.photo ?? ""), placeholderImage: UIImage())
        
        
    }
    
    
    
}
