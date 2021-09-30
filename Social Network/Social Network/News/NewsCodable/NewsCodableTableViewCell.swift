//
//  NewsCodableTableViewCell.swift
//  Social Network
//
//  Created by Alex on 08.08.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage

class NewsCodableTableViewCell: UITableViewCell {
    
    
    @IBAction func likeButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBAction func commentsButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var commentsCount: UILabel!
    
    @IBAction func repostButton(_ sender: UIButton) {
    }
    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var dataNews: UILabel!
    @IBOutlet weak var mainImageNews: UIImageView!
    @IBOutlet weak var mainTextNews: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(item: Item, profile: Profile? = nil, group: Group? = nil, index: Int) {
        
        if let group = group {
            profileName.text = group.name
            
            AF.request(group.photo50!, method: .get).responseImage { response in
                guard let image = response.value else { return }
                self.profilePhoto.image = image
            }
            
        } else {
            if let profile = profile {
                
                profileName.text = "\(profile.firstName ?? "") \(profile.lastName ?? "")"
                
                AF.request(profile.photo100!, method: .get).responseImage { response in
                    guard let image = response.value else { return }
                    self.profilePhoto.image = image
                }
            }
        }
        
        likeCount.text = "\(item.likes.count)"
        commentsCount.text = "\(item.comments!.count)"
        mainTextNews.text = item.text
        dataNews.text = item.date.getDateStringFromUTC()


        if item.attachments != nil {
            if let firstAttachment = item.attachments?[0] {

                switch firstAttachment.type {

                case "video":
                    self.mainImageNews.image = UIImage(named: "DefaultImage")
                    
                case "link" :
                    if let photoNews = firstAttachment.photo?.size?[0].url {
                        AF.request(photoNews, method: .get).responseImage { response in
                            guard let image = response.value else { return }
                            self.mainImageNews.image = image
                        }
                    }

                case "photo" :
                    if let photoNews = firstAttachment.photo?.size?[0].url {
                        AF.request(photoNews, method: .get).responseImage { response in
                            guard let image = response.value else { return }
                            self.mainImageNews.image = image
                        }
                    }

                default:

                    self.mainImageNews.image = UIImage(named: "DefaultImage")
                }
            }
        }
        
    }
    
}


