//
//  WirteVC.swift
//  NetworkSeminar
//
//  Created by 남수김 on 29/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class WriteVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func uploadBtnAction(_ sender: Any) {
        guard let image = UIImage(named: "defaultImg") else { return }
        guard let content = textView.text else{return}
        
        CommentService.shared.writeComment(epIdx: 9, content: content, cmtImg: image) {
            data in
            
            switch data {
            case .success(_):
                print("성공")
                break
            case .requestErr(let err):
                print(err)
                break
            case .pathErr:
                print("경로 에러")
                break
            case .serverErr:
                print("서버 에러")
                break
            case .networkFail:
                print("네트워크 에러")
                break
            }
        }
    }
    
}
