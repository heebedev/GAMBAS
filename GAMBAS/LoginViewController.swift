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

class LoginViewController: UIViewController {

    @IBOutlet weak var kakaoLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        self.performSegue(withIdentifier: "sgLogin", sender: nil)
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
