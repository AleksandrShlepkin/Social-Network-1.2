//
//  NewsSecondTableViewCell.swift
//  Social Network
//
//  Created by Alex on 02.08.2021.
//

import UIKit

class NewsSecondTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var tittleNews: UILabel!
    @IBOutlet weak var textNews: UILabel!
    
    func config(news: News){
        if let image = news.urlImage {
            imageNews.sd_setImage(with: URL(string: image), placeholderImage: UIImage())
        }
        if let title = news.text {
            tittleNews.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
