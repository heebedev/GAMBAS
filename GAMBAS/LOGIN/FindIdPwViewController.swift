//
//  FindIdPwViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/28.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class FindIdPwViewController: UIViewController, CheckFindIdPwModelProtocol {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfBirth: UITextField!
    
    @IBOutlet weak var tfName_pw: UITextField!
    @IBOutlet weak var tfBirth_pw: UITextField!
    @IBOutlet weak var tfId: UITextField!
    
    var userSeqno:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnID(_ sender: UIButton) {
        let checkName = tfName.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: "", with: "")
        let checkBirth = tfBirth.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: "", with: "")
        if checkName.isEmpty || checkBirth.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "이름과 생년월일을 확인해주세요.", actionTitle: "OK", handler: nil)
        } else {
            let findId = CheckFindIdPwModel()
            findId.delegate = self
            findId.downloadItems(code: "findId", id : "", name: checkName, birth: checkBirth)
        }
    }
    
    @IBAction func btnPassword(_ sender: UIButton) {
        let checkId = tfId.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
        let checkName = tfName_pw.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
        let checkBirth = tfBirth_pw.text!.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: " ")
        
        if checkId.isEmpty || checkName.isEmpty || checkBirth.isEmpty {
            myAlert(alertTitle: "확인", alertMessage: "아이디, 이름, 생년월일을 확인해주세요.", actionTitle: "OK", handler: nil)
        } else {
            let findPw = CheckFindIdPwModel()
            findPw.delegate = self
            findPw.downloadItems(code: "findPw", id : checkId, name: checkName, birth: checkBirth)
        }
    }
    
    func itemDownloaded(code: String, item: String) {
        switch code {
        case "findId":
            if item == "false" {
                myAlert(alertTitle: "확인", alertMessage: "가입된 정보가 없습니다.", actionTitle: "OK", handler: nil)
            } else {
                myAlert(alertTitle: "확인", alertMessage: "아이디는 \(item)입니다.", actionTitle: "OK", handler: nil)
            }
        default:
            if item == "false" {
                myAlert(alertTitle: "확인", alertMessage: "회원정보가 일치하지 않습니다.", actionTitle: "OK", handler: nil)
            } else {
                userSeqno = Int(item)
                self.performSegue(withIdentifier: "sgChangePw", sender: self)
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgChangePw"){
            let displayVC = segue.destination as! ChangePwViewController
            displayVC.uSeqno = userSeqno!
        }
    }
    
    func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
        let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil)
    }
}
