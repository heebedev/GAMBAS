//
//  MainViewController.swift
//  GAMBAS
//
//  Created by TJ on 21/09/2020.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,LoginModelProtocol {

    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPassWord: UITextField!
       
       var userEmail:String?
       var uSeqno:String = ""
       var feedItem: NSArray = NSArray()
       
       var feedItems: NSArray = NSArray()
       var userPassword:String?
       
       var autoLogin = false
       var receiveuSeqno = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
            loginAction()
        }
    
        func loginAction(){
            self.userEmail = tfId.text!
            self.userPassword = tfPassWord.text!
            if(self.userEmail == nil || self.userEmail == ""){
                myAlert(alertTitle: "오류", alertMessage: "아이디 비밀번호를 확인해주세요.", actionTitle: "OK", handler: nil)
                LoginChkDownloaded(item: userEmail!, items: userPassword!)
            } else {
            let queryModel = LoginModel()
                queryModel.delegate = self
                queryModel.EmailloadItems(uEmail: userEmail!, uValidation: "1")

            }
        }
        
        
        @IBAction func btnKaKao(_ sender: UIButton) {
            
        }
        
        
        func LoginChkDownloaded(item: String, items: String) {
            if items == "false" {
                      myAlert(alertTitle: "확인", alertMessage: "등록되지 않은 정보입니다.", actionTitle: "OK", handler: nil)
                  } else if items != tfPassWord.text! {
                      myAlert(alertTitle: "비밀번호 오류", alertMessage: "비밀번호가 일치하지 않습니다.", actionTitle: "OK", handler: nil)
                  }
        }

        func LoginitemDownloaded(items: NSArray) {
            feedItem = items
            let item: SigupDBModel = feedItem[0] as! SigupDBModel
            uSeqno = item.uSepno!

        }
        
        
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

        
        // ********************** 기본 ALERT
           func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
                 let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                 let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
                 resultAlert.addAction(onAction)
                 present(resultAlert, animated: true, completion: nil)
             }

           // ********************** 이메일 CHECK
           func isValidEmail(emailStr:String) -> Bool {
               let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

               let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
               return emailPred.evaluate(with: emailStr)
           }
    }

