//
//  CollectionVC.swift
//  insta_CollectionTableView
//
//  Created by 남수김 on 24/05/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var contents = [Contents]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        //데이터추가
        dataSet()
        
    }
    @IBAction func addButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CollectionVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstaCollectionViewCell", for: indexPath) as? InstaCollectionViewCell else {fatalError()}
        
        cell.backgroundColor = UIColor.white
        let content = contents[indexPath.row]
        
        cell.userImageIcon.image = content.userIconImage
        cell.userIdLabel.text = content.userId
        cell.photo.image = content.photo
        cell.likeLabel.text = "좋아요 \(content.like)개"
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }

    
}

extension CollectionVC: UICollectionViewDelegateFlowLayout{
    
    //셀 크기지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width
        let height: CGFloat = view.frame.width+100
        
        return CGSize(width: width, height: height)
    }
    
    //행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
}

extension CollectionVC {
    func dataSet(){
        let item1 = Contents.init(iconName: "오구", userid: "dev_insta", photoName: "풍경", like: 563, comment: "안녕하세요", commentNum: 104)
        
        let item2 = Contents.init(iconName: "뽀로로", userid: "dev_pang", photoName: "풍경2", like: 777, comment: "노는게 제일좋아", commentNum: 2019)
        
        let item3 = Contents.init(iconName: "주디", userid: "dev_judy", photoName: "풍경3", like: 1004, comment: "뀨뀨 쀼쀼 >_<", commentNum: 224)
        
        
        contents = [item1, item2, item3]
    }
}
