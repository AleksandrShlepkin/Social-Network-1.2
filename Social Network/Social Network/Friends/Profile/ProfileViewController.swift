//
//  ProfileViewController.swift
//  Social Network
//
//  Created by Alex on 03.07.2021.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet var profileView: UIView!
    private var apiservice = APIService()
    var profileFriends: FriendsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
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
