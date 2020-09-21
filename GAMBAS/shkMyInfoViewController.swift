//
//  shkMyInfoViewController.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class shkMyInfoViewController: UIViewController {

    @IBOutlet var lbmyInfoName: UITextField!
    @IBOutlet var lbmyInfoEmail: UITextField!
    @IBOutlet var lbmyInfoPhone: UITextField!
    @IBOutlet var lbmyInfoInterest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 내 정보에서 이름 수정 불가
        lbmyInfoName.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func barbtnMyInfoUpdate(_ sender: UIBarButtonItem) {
        let email = lbmyInfoName.text
        let emailCheck = isEmail(email: email!)
        let phone = lbmyInfoPhone.text
        let phoneCheck = isPhone(candidate: phone!)
        // 유저 구분을 위한 값 저장
        let seq = String(LOGED_IN_SEQ)
        
        if !phoneCheck {
            let phoneAlert = UIAlertController(title: "확인 요청", message: "휴대폰 번호 확인 부탁드립니다", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            phoneAlert.addAction(onAction)
            present(phoneAlert, animated: true, completion: nil)
        }
        
        if !emailCheck {
            let emailAlert = UIAlertController(title: "확인 요청", message: "휴대폰 번호 확인 부탁드립니다", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            emailAlert.addAction(onAction)
            present(emailAlert, animated: true, completion: nil)
        }
        
        let updateModel = SKHmyInfoUpdateModel()
        let result = updateModel.SKHmyInfoUpdateItems(email: email!, phone: phone!, seq: seq)
        
        if result {
            let resultAlert = UIAlertController(title: "완료", message: "수정이 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
            _ = navigationController?.popViewController(animated: true)
        } else {
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "failed", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
        
        
    }
    
    // 이메일 형식 확인
    func isEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    
    // 휴대폰 형식 확인
    func isPhone(candidate: String) -> Bool {
            let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: candidate)
    }

}
