//
//  ChangePwViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/28.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class ChangePwViewController: UIViewController {

    var uSeqno:Int = 0
    
    @IBOutlet weak var tfNewPw: UITextField!
    @IBOutlet weak var tfNewPwChk: UITextField!
    @IBOutlet weak var lbChkMent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         lbChkMent.text = ""
    }
    

    @IBAction func btnChangePw(_ sender: UIButton) {
        let newPw = tfNewPw.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
            let newPwChk = tfNewPwChk.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "")
            
            if newPw.isEmpty {
                lbChkMent.text = "비밀번호를 입력해주세요."
            } else if newPwChk.isEmpty {
                lbChkMent.text = "비밀번호를 다시한번 확인해주세요."
            } else if newPw != newPwChk {
                lbChkMent.text = "비밀번호가 다릅니다."
            } else {
                let psChange = passwordChangeModel()
                psChange.passwordChangeItems(uSeqno: uSeqno, uPassword: newPw)
                myAlert(alertTitle: "비밀번호 변경 완료", alertMessage: "비밀번호가 변경되었습니다.", actionTitle: "OK", handler: {Action in
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                })
            }
            
        }
        
        func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
            let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }

}
