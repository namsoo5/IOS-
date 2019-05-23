//
//  InstaObject.swift
//  insta_CollectionTableView
//
//  Created by 남수김 on 23/05/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit

struct Contents {
    var userIconImage: UIImage?
    var userId: String
    var photo: UIImage?
    var like: Int
    var userComment: String
    var commentNum: Int
    
    init(iconName icon :String, userid id :String, photoName pname :String, like l :Int, comment c :String, commentNum cn :Int) {
        
        userIconImage = UIImage(named: icon)
        userId = id
        photo = UIImage(named: pname)
        like = l
        userComment = c
        commentNum = cn
    }
}
