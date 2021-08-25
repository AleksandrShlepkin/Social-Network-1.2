//
//  ProfileViewController.swift
//  Social Network
//
//  Created by Alex on 03.07.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Firebase

class ProfileViewController: UIViewController {
    
    
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    let ref = Database.database().reference(withPath: "Friends")

    @IBAction func addFriend(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Добавить в друзья", message: "Вы хотите добавить в друзья?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Добавить", style: .default, handler: nil)
        
//        let friendAdd = FireBaseFriendsModel.init(id: profileFriends?.userID ?? "")
//        let friendRef = self.ref.child(Session.shared.userID).child(profileFriends?.userID ?? "")
//        friendRef.setValue(friendAdd.toAnyObject())
        
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
        
    }
    let config = Realm.Configuration(schemaVersion: 1)
//    lazy var realm = try! Realm(configuration: config)
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet var profileView: UIView!
    private var apiservice = APIService()
//    var profileFriends: FriendsModel?
    var profilePhoto: PhotoModel?
//    var realmService: RealmService?
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        

      
        }
//
        
        
      
    }
    


extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        cell.profilePhoto.sd_setImage(with: URL(string: profilePhoto?.photoID ?? ""), placeholderImage: UIImage())
        return cell
    }


}
