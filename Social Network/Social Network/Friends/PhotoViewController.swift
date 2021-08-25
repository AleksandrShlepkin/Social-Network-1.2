//
//  PhotoViewController.swift
//  Social Network
//
//  Created by Alex on 01.07.2021.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoCollection: UICollectionView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
//extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        photos.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
//        let photo = photos[indexPath.row]
//        cell.photoCell.sd_setImage(with: URL(string: photo.photo ?? ""), placeholderImage: UIImage())
//        return cell
//        
//    }
//    
//    
//}
