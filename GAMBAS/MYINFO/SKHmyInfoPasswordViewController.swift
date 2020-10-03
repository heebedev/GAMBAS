//
//  SKHmyInfoPasswordViewController.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

// 비밀번호 확인 - 비밀번호 변경 하기 전 뷰 컨트롤러

class SKHmyInfoPasswordViewController: UIViewController, SkhmyInfoModelProtocol{
    
    var feedItem: Int = 2
    var ivSKHcount = 1
    var ivSKHcheckPw = ""
    
    let uSeqno = UserDefaults.standard.integer(forKey: "uSeqno")
    
    func itemDownloaded(items: Int) {
        feedItem = items
        print("feedItem \(feedItem)")
        
        if feedItem != 1 {
            let checkAlert = UIAlertController(title: "확인 요청", message: "비밀번호가 일치하지 않습니다. 확인 부탁드립니다.", preferredStyle: UIAlertController.Style.alert)
            let addAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            checkAlert.addAction(addAction)
            present(checkAlert, animated: true, completion: nil)
            print("fail ivSKHcount \(feedItem)")
        } else if feedItem == 1 {
            print("feedItemCheck = \(feedItem)")
            self.performSegue(withIdentifier: "changePWmyInfo", sender: nil)
        }
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
        } else {
            let queryModel = SkhmyInfoPwCheckModel()
            queryModel.delegate = self
            queryModel.checkCount(password: ivSKHcheckPw, seq: uSeqno)
        }
        
    }
    
    
}
