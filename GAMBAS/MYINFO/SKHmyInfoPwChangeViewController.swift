//
//  SKHmyInfoPwChangeViewController.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/19.
//  Copyright © 2020 TJ. All rights reserved.
//

// 이전 뷰 컨트롤러에서 비밀번호 확인 후 비밀번호 변경 진행

import UIKit

class SKHmyInfoPwChangeViewController: UIViewController {

    @IBOutlet var lbPwChange: UITextField!
    @IBOutlet var lbPwChangeCheck: UITextField!
    
    var ivSKHpwChange = ""
    var ivSKHpwChangeCheck = ""
    
    let uSeqno: String = String(UserDefaults.standard.integer(forKey: "uSeqno"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPwChange(_ sender: UIButton) {
        ivSKHpwChange = lbPwChange.text!
        ivSKHpwChangeCheck = lbPwChangeCheck.text!
        
        // 비밀번호 공백 체크
        if (ivSKHpwChange.isEmpty) && (ivSKHpwChangeCheck.isEmpty) {
            let resultAlert = UIAlertController(title: "입력 요청", message: "비밀번호를 입력부탁드립니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        } else {        // 비밀번호가 일치하는지 체크
            if (ivSKHpwChange == ivSKHpwChangeCheck) {
                let skhmyInfopwChangeModel = SKHmyInfopwChangeModel()
                let result = skhmyInfopwChangeModel.SKHmyInfoUpdateItems(password: ivSKHpwChange, seq: uSeqno)
                
                // 아래 identifier - myInfoAllView - 내 감바스(마이 인포 메인) 뜻함
                
                if result {
                    let resultAlert = UIAlertController(title: "완료", message: "수정이 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
                    let onAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    })
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil)
                } else {
                    let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                    let onAction = UIAlertAction(title: "failed", style: UIAlertAction.Style.default, handler: nil)
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil)
                }
            } else {
                let resultAlert = UIAlertController(title: "확인", message: "비밀번호가 일치하지 않습니다. 확인 부탁드립니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
            }
        }
    }
    
    
} // --------
