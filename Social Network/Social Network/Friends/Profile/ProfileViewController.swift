//
//  ProfileViewController.swift
//  Social Network
//
//  Created by Alex on 03.07.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class ProfileViewController: UIViewController {
    
    let config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet var profileView: UIView!
    private var apiservice = APIService()
    var profileFriends: FriendsModel?
    var profilePhoto: PhotoModel?
    var realmService: RealmService?
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let friendProfile = realm.objects(FriendsModel.self)
        self.token = friendProfile.observe{ (changes: RealmCollectionChange) in
            switch changes {
            case .initial(let results):
                print(results)
            case let .update(results ,deletions, insertions, modifications ):
                print(results, deletions, insertions, modifications)
            case .error(let error):
                print(error)
            }

        }
      let profile1 = realmService?.read()
        print(realm.configuration.fileURL as Any)
//        do {
//            self.realm.beginWrite()
//            self.realm.add(profileFriends!)
//            try self.realm.commitWrite()
//            print(realm.configuration.fileURL as Any)
//        } catch {
//            print(error)
//        }
        
        
        nameProfile.text = " \( profileFriends?.firstName ?? "") \(profileFriends?.lastName ?? "")"
        photoProfile.sd_setImage(with: URL(string: profileFriends?.photo ?? ""), placeholderImage: UIImage())
        
    }
    

}
//extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return profileFriends.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =
//    }
//
//
//}
