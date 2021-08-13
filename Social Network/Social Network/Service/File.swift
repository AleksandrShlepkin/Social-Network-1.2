//
//  File.swift
//  Social Network
//
//  Created by Alex on 11.08.2021.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.isUserInteractionEnabled = true
    }
    
}
