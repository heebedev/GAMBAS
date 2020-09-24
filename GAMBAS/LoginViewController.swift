//
//  LoginViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController, LoginQuaryModelProtocol {

    @IBOutlet weak var tfKSHloginId: UITextField!
    @IBOutlet weak var tfKSHloginPw: UITextField!
    
    var userId:String?
    var userPw:String?
    var uSeqno:String = ""
    
    var autoLogin = false
    var receiveuSeqno = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //******************* 혹시 uSeqno 정보가 남아있을 때 삭제.
        UserDefaults.standard.removeObject(forKey: "uSeqno")

        //******************* 버튼 모양
        self.reloadInputViews()

    }
    
    func LoginChkDownloaded(uSeqno: String, uResult: String) {
        if uResult == "false" {
            myAlert(alertTitle: "확인", alertMessage: "등록되지 않은 정보입니다.", actionTitle: "OK", handler: nil)
        } else if uResult != tfKSHloginPw.text! {
            myAlert(alertTitle: "비밀번호 오류", alertMessage: "비밀번호가 일치하지 않습니다.", actionTitle: "OK", handler: nil)
        } else {
            UserDefaults.standard.set(Int(uSeqno), forKey: "uSeqno")
            self.performSegue(withIdentifier: "sgLogin", sender: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnLogin(_ sender: UIButton) {
        self.userId = tfKSHloginId.text!
        self.userPw = tfKSHloginPw.text!
        print("ID \(String(describing: userId)) PW \(String(describing: userPw))")
        if(self.userId == nil || self.userId == ""){
            myAlert(alertTitle: "오류", alertMessage: "아이디 비밀번호를 확인해주세요.", actionTitle: "OK", handler: nil)
        } else {
        let queryModel = LoginQuaryModel()
            queryModel.delegate = self
            queryModel.IdCheckItems(userId!)
        }
    }
    
    // ********************** 기본 ALERT
    func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
        let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func kakaoLoginButton(_ sender: UIButton) {
        kakaoLoginAction()
    }
    
    func kakaoLoginAction(){
            AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                //do something
                let _ = oauthToken
            }
            UserApi.shared.me() {(user, error) in
                if let error = error {
                    print(error)
                }
//                else {
//                    print("me() success.")
//                    //do something
//                    _ = user
//                    self.userEmail = user?.kakaoAccount?.email
//                    if(self.userEmail == nil || self.userEmail == ""){
//
//                    }else{
//                    let queryModel = KakaoLoginQueryModel()
//                    queryModel.delegate = self
//                    queryModel.downloadItems(uEmail: self.userEmail!)
//                    }
//                }
            }
        }
    }
    

}
