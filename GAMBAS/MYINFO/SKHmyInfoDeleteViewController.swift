//
//  SKHmyInfoDeleteViewController.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/21.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit

// 내 정보에서 회원탈퇴 진행하는 부분 (비밀번호 일치 후 userinfo에서 uValidation을 0으로 업데이트 후 "그동안 GAMBAS를 이용해주셔서 감사합니다." 알람창 띄운 뒤 최초 메인 화면으로 보냄. 그로인해 아래 identifier -(현재 main으로 되어 있음) 부분 수정필요!!)

class SKHmyInfoDeleteViewController: UIViewController, SkhmyInfoModelProtocol {
    
    var feedItem: Int = 2
    
    func itemDownloaded(items: Int) {
        feedItem = items
        
        if feedItem != 1 {
            let checkAlert = UIAlertController(title: "확인 요청", message: "비밀번호가 일치하지 않습니다. 확인 부탁드립니다.", preferredStyle: UIAlertController.Style.alert)
            let addAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            checkAlert.addAction(addAction)
            present(checkAlert, animated: true, completion: nil)
            //print("fail ivSKHcount \(feedItem)")
        } else if feedItem == 1 {
            let skhMyinfoDeleteModel = SKHmyInfopwDeleteModel()
            let result = skhMyinfoDeleteModel.SKHmyInfoUpdateItems(seq: String(LOGED_IN_SEQ))
            
            if result {
                let resultAlert = UIAlertController(title: "완료", message: "그동안 GAMBAS를 이용해주셔서 감사합니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                   guard let uvc = self.storyboard?.instantiateViewController(identifier: "main")
                       else {
                           return
                   }
                   uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                   self.navigationController?.pushViewController(uvc, animated: true)
                })
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
                } else {
                let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "failed", style: UIAlertAction.Style.default, handler: nil)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
            }
            
        }
    }
    

    @IBOutlet var lbPwCheck: UITextField!
    
    var ivSKHpassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUserDelete(_ sender: UIButton) {
        ivSKHpassword = lbPwCheck.text!
        
        if ivSKHpassword.isEmpty {
            let phoneAlert = UIAlertController(title: "확인 요청", message: "비밀번호 입력 부탁드립니다", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            phoneAlert.addAction(onAction)
            present(phoneAlert, animated: true, completion: nil)
        }
        
        let checkModel = SkhmyInfoPwCheckModel()
        checkModel.delegate = self
        checkModel.checkCount(password: ivSKHpassword, seq: LOGED_IN_SEQ)
    }
    

}
