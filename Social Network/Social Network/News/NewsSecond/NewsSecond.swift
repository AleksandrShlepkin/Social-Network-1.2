//
//  File.swift
//  Social Network
//
//  Created by Alex on 18.08.2021.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import WebKit
import TTTAttributedLabel
class FirstCell: UITableViewCell {
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var postData: UILabel!
    @IBOutlet weak var profileOnline: UILabel!
    
    func configure(profile: Profile? = nil, group: Group? = nil, postDateFunc: Double?) {
        
        if let group = group {
            profileName.text = group.name
            
            AF.request(group.photo100!, method: .get).responseImage { response in
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
        postData.text = postDateFunc?.getDateStringFromUTC()
        
    }
    
}
class SecondCell: UITableViewCell {
    @IBOutlet weak var mainPhotoNews: UIImageView!
    
    func configure(url: String? = nil) {
        
        if  url == nil {
            mainPhotoNews.image = UIImage(named: "DefaultImage")
        } else {
            AF.request(url!, method: .get).responseImage { response in
                guard let image = response.value else { return }
                self.mainPhotoNews.image = image
                
                
            }
        }
    }
    
}
class ThirdCell: UITableViewCell {
    @IBOutlet weak var mainTextNews: TTTAttributedLabel!
    
    let kCharacterBeforReadMore =  20
    let kReadMoreText           =  "Читать далее.."
    let kReadLessText           =  "Свернуть"
    
    
    func readMore(readMore: Bool) {
        mainTextNews.showTextOnTTTAttributeLable(str: mainTextNews.text as! String, readMoreText: kReadMoreText, readLessText: kReadLessText, font: nil, charatersBeforeReadMore: kCharacterBeforReadMore, activeLinkColor: UIColor.blue, isReadMoreTapped: readMore, isReadLessTapped: false)
          }
          func readLess(readLess: Bool) {
            mainTextNews.showTextOnTTTAttributeLable(str: mainTextNews.text as! String, readMoreText: kReadMoreText, readLessText: kReadLessText, font: nil, charatersBeforeReadMore: kCharacterBeforReadMore, activeLinkColor: UIColor.blue, isReadMoreTapped: readLess, isReadLessTapped: true)
          }

    func configure(text: String?) {
        mainTextNews.text = text
        mainTextNews.showTextOnTTTAttributeLable(str: text!, readMoreText: kReadMoreText, readLessText: kReadLessText, font: UIFont.init(name: "Helvetica-Bold", size: 24.0)!, charatersBeforeReadMore: kCharacterBeforReadMore, activeLinkColor: UIColor.blue, isReadMoreTapped: false, isReadLessTapped: false)
        mainTextNews.delegate = self
    }
    
}
    
class FourCell: UITableViewCell {
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var comentsCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var repostCount: UILabel!
}

