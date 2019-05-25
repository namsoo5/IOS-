//
//  ViewController.swift
//  insta_CollectionTableView
//
//  Created by 남수김 on 23/05/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var contents = [Contents]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        dataSet()
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(contents.count)
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InstaTableViewCell") as? InstaTableViewCell else {fatalError()}
        
        let content = contents[indexPath.row]
        
        cell.userImageIcon.image = content.userIconImage
        cell.userIdLabel.text = content.userId
        cell.photo.image = content.photo
        cell.likeCount = content.like
        cell.likeLabel.text = "좋아요 \(cell.likeCount)개"
        cell.commentUserIdLabel.text = content.userId
        cell.comment.text = content.userComment
        cell.commentNumLabel.text = "댓글 \(content.commentNum)개 모두 보기"
        
        cell.userIdLabel.sizeToFit()
        cell.likeLabel.sizeToFit()
        cell.commentUserIdLabel.sizeToFit()
        cell.comment.sizeToFit()
        cell.commentNumLabel.sizeToFit()
        return cell
    }
    
    
}

extension ViewController {
    func dataSet(){
        let item1 = Contents.init(iconName: "오구", userid: "dev_insta", photoName: "풍경", like: 563, comment: "안녕하세요", commentNum: 104)
        
         let item2 = Contents.init(iconName: "뽀로로", userid: "dev_pang", photoName: "풍경2", like: 777, comment: "노는게 제일좋아", commentNum: 2019)
        
         let item3 = Contents.init(iconName: "주디", userid: "dev_judy", photoName: "풍경3", like: 1004, comment: "뀨뀨 쀼쀼 >_<", commentNum: 224)
        
        
        contents = [item1, item2, item3]
    }
}
