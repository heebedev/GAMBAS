//
//  SKHmyInfoPasswordViewController.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

class SKHmyInfoPasswordViewController: UIViewController, SkhmyInfoModelProtocol{
    
    var feedItem: String = ""
    var ivSKHcount = ""
    var ivSKHcheckPw = ""
    
    func itemDownloaded(items: String) {
        feedItem = items
    }
    

    @IBOutlet var lbCurrentPassword: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func btnPwCheck(_ sender: Any) {
        ivSKHcheckPw = lbCurrentPassword.text!
        if lbCurrentPassword.text!.isEmpty {
            let phoneAlert = UIAlertController(title: "확인 요청", message: "비밀번호 입력 부탁드립니다", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            phoneAlert.addAction(onAction)
            present(phoneAlert, animated: true, completion: nil)
        }
        
        let queryModel = SkhmyInfoPwCheckModel()
        queryModel.delegate = self
        queryModel.checkCount(password: ivSKHcheckPw, seq: LOGED_IN_SEQ)
        
        
        
        
    }
    
    
}
