//
//  NewsTableViewCell.swift
//  Social Network
//
//  Created by Alex on 23.07.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    func config(news: News) {
        if let image = news.urlImage {
            newsImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage())
        }
        if let title = news.text {
            newsLabel.text = title
        }
    }
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   
}
