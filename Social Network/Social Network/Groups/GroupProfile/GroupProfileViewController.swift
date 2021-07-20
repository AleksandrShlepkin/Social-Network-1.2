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
    
    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBAction func addGroup(_ sender: UIButton) {
    }
    
    
    
    
    var groupProfile: GroupsModel?
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
//        nameGroup.text = "\(groupProfile.name)"
              
    }
    


}
