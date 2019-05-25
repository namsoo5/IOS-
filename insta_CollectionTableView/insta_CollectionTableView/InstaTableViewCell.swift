//
//  InstaTableViewCell.swift
//  insta_CollectionTableView
//
//  Created by 남수김 on 23/05/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class InstaTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageIcon: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentUserIdLabel: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var likeCount = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageIcon.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        if !sender.isSelected {  //미선택상태일때 클릭시
            sender.isSelected = !sender.isSelected
            sender.setBackgroundImage(UIImage(named: "like"), for: .normal)
            likeCount += 1
            likeLabel.text = "좋아요 \(likeCount)개"
            
        }else {
            sender.isSelected = !sender.isSelected
            sender.setBackgroundImage(UIImage(named: "heart"), for: .normal)
            
            likeCount -= 1
            likeLabel.text = "좋아요 \(likeCount)개"
        }
    }
    

}
