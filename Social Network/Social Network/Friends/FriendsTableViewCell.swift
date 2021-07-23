//
//  FriendsTableViewCell.swift
//  Social Network
//
//  Created by Alex on 22.07.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var labelFriends: UILabel!
    @IBOutlet weak var imageFriend: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
