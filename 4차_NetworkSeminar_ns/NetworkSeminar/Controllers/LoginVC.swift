//
//  LoginVC.swift
//  NetworkSeminar
//
//  Created by 남수김 on 05/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var stackViewCenterY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        guard let id = idTextField.text else{return}
        guard let pw = pwTextField.text else{return}
        
        AuthService.shared.login(id, pw) {
            data in
            
            switch data {
            case .success(let token):
                // 통신에 성공한 경우, success 가 true 인 경우
                UserDefaults.standard.set(token, forKey: "token")
                print(token)
                
                //storyboard의 이름
                let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNC") as! UINavigationController
                
                self.present(dvc, animated: true)
                
                break
            case .requestErr(let err):
                // 통신엔 성공했으나 response body 내에 success 가 false 인 경우
                self.simpleAlert(title: "로그인 실패", message: err as! String)
                print(err)
                break
            case .pathErr:
                // 대체로 경로를 잘못 쓴 경우입니다.
                // 오타를 확인해보세요.
                print("경로 에러")
                break
            case .serverErr:
                // 서버의 문제인 경우입니다.
                // 여기에서 동작할 행동을 정의해주시면 됩니다.
                print("서버 에러")
                break
            case .networkFail:
                // 이 경우엔 reachability 를 이용해서 현재 네트워크 상태를 검사하고
                // 앱을 종료시키거나 메시지를 표시하면 됩니다.
                // reachability 에 대해서 구글링해보세요!
                self.simpleAlert(title: "통신 실패", message: "네트워크 상태를 확인하세요.")
                print("네트워크 에러")
                break
            }
        }
    }
    
    func setViews(){
        //extension func
        //모서리 둥글게
        idView.makeRounded(cornerRadius: nil)
        pwView.makeRounded(cornerRadius: nil)
        loginBtn.makeRounded(cornerRadius: nil)
        
        //테투리
        idView.setBorder(borderColor: UIColor.veryLightPinkTwo, borderWidth: 0.5)
        pwView.setBorder(borderColor: UIColor.veryLightPinkTwo, borderWidth: 0.5)
        
        //그림자
        loginBtn.dropShadow(color: UIColor.veryLightPink52, offSet: CGSize(width: 0, height: 3), opacity: 1.0, radius: 3)
    }
}

extension LoginVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.idTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: idTextField))! || (touch.view?.isDescendant(of: pwTextField))! {
            
            return false
        }
        return true
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        //주기
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        //키보드 높이가져오기위함
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            //ishidden인경우 true false뿐이므로 부드럽지가않음
            //0으로하면 duration만큼 쪼개면서 효과가 적용되므로 부드러움
            self.logoImageView.alpha = 0
            self.stackViewCenterY.constant = -keyboardHeight/2
        })
        //꼭호출 해줘야 적용됨
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.logoImageView.alpha = 1.0
            self.stackViewCenterY.constant = 0
        })
        
        self.view.layoutIfNeeded()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
