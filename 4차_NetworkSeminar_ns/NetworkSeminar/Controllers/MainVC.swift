//
//  MainVC.swift
//  NetworkSeminar
//
//  Created by 남수김 on 05/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var webtoonList: [Webtoon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWebtoon(flag: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func getWebtoon(flag: Int) {
        WebtoonService.shared.getWebtton(flag){
            
            data in
            
            switch data {
            case .success(let data):
                let res = data as! [Webtoon]
                self.webtoonList = res
                OperationQueue.main.addOperation {
                     self.collectionView.reloadData()
                }
                break
                
            case .requestErr(_):
                break
            case .pathErr:
                break
            case .serverErr:
                break
            case .networkFail:
                break
                
            }
        }
    }
    
    @IBAction func flagBtnAction(_ sender: Any){
        
    }
}

// UICollectionViewDataSource 를 채택합니다.
extension MainVC: UICollectionViewDataSource {
    
    // UICollectionView 에 얼마나 많은 아이템을 담을 지 설정합니다.
    // 현재는 musicList 배열의 count 갯수 만큼 반환합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return webtoonList.count
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WebtoonCell", for: indexPath) as! WebtoonCVC
        
        let webtoon = webtoonList[indexPath.row]
        
        guard let imgUrl:URL = URL(string: webtoon.thumnail) else {fatalError()}
        do{
            let imgData:Data = try Data(contentsOf: imgUrl)
            cell.thumbnail.image = UIImage(data: imgData)
        }catch{
            fatalError()
        }
        
        cell.title.text = webtoon.title
        cell.author.text = webtoon.name
        
        return cell
    }
}

// UICollectionViewDelegate 를 채택합니다.
extension MainVC: UICollectionViewDelegate {
    
    /*
     didSelectItemAt 은 셀을 선택했을때 어떤 동작을 할 지 설정할 수 있습니다.
     여기서는 셀을 선택하면 그에 해당하는 MusicDetailVC 로 화면전환을 합니다.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

/*
 UICollectionViewDelegateFlowLayout 을 채택합니다.
 바로 위의 UICollectionViewDelegate 내부의 메소드를 이 안에 넣어도 상관 없지만 가독성을 위해 분리했습니다.
 
 이 곳에서는 CollectionView 의 레이아웃을 관리합니다.
 */
extension MainVC: UICollectionViewDelegateFlowLayout {
    
    // Collection View Cell 의 width, height 를 지정할 수 있습니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (view.frame.width) / 3
        let height: CGFloat = (view.frame.width) / 3 + 44
        
        return CGSize(width: width, height: height)
    }
    
    // minimumLineSpacingForSectionAt 은 수직 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    // minimumInteritemSpacingForSectionAt 은 수평 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    // insetForSectionAt 섹션 내부 여백을 말합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
