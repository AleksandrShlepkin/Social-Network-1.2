//
//  ProfileFriendsViewController.swift
//  Social Network
//
//  Created by Alex on 29.08.2021.
//

import UIKit
import SDWebImage
import Alamofire

class ProfileFriendsViewController: UIViewController {

    @IBOutlet weak var collectionPhotoProfile: UICollectionView!
    @IBOutlet var profileMainView: UIView!
    
    
    //MARK: Аутлеты профайла
    @IBOutlet weak var mainPhotoProfile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileBDate: UILabel!
    @IBOutlet weak var onlineStatus: UILabel!
    
    
    var friends: [ItemFriends]!
    let apiServise = FriendsAPI()
    let apiPhoto = PhotoAPI()
    var photos: [ItemPhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionPhotoProfile.delegate = self
        collectionPhotoProfile.dataSource = self
        
        apiPhoto.getPhoto { [ weak self ] photo in
            guard let self = self else { return }
            self.photos = photo!.response.items
            self.collectionPhotoProfile.reloadData()
            
           
        }

        mainPhotoProfile.sd_setImage(with: URL(string: friends?[0].photo100 ?? ""), placeholderImage: UIImage())
        profileName.text = "\(friends?[0].firstName ?? "") \(friends?[0].lastName ?? "")"

        if friends?[0].bdate == nil {
            profileBDate.text = ""
        } else {
        profileBDate.text = "День рождения \(friends[0].bdate ?? "")"
    }
    }
    



}

extension ProfileFriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPhotoProfile.dequeueReusableCell(withReuseIdentifier: "collectionPhoto", for: indexPath) as! PhotoFriendsCollectionViewCell
        AF.request(photos[indexPath.row].sizes[0].url, method: .get).responseImage { response in
            guard let image = response.value else { return }
            cell.collectionPhoto.image = image
        }
        
                return cell
    }
    
    
}
