//
//  InstaCollectionViewCell.swift
//  insta_CollectionTableView
//
//  Created by 남수김 on 24/05/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class InstaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageIcon: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentUserIdLabel: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var commentNumLabel: UILabel!
    
    override func awakeFromNib() {
        userImageIcon.layer.cornerRadius = 20
        
        
    }
    @IBAction func likeButton(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = !sender.isSelected
            sender.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }else{
            sender.isSelected = !sender.isSelected
            sender.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
}
