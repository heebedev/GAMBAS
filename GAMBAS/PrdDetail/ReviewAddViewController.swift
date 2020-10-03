//
//  ReviewAddViewController.swift
//  GAMBAS
//
//  Created by 김승희 on 2020/09/24.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase



class ReviewAddViewController: UIViewController, prdDetailQueryModelProtocol {
    
    var feedItem: NSArray = NSArray()
    
    
    @IBOutlet weak var tfKSHReviewTitle: UITextField!
    @IBOutlet weak var trKSHReviewContent: UITextView!
    
    @IBOutlet weak var ivKSHRvChannelImage: UIImageView!
    @IBOutlet weak var lbKSHRvChannelName: UILabel!
    @IBOutlet weak var lbKSHRvChannelGrade: UILabel!
    @IBOutlet weak var lbKSHRvChannelSubs: UILabel!
    
    @IBOutlet weak var btnStarNum1: UIButton!
    @IBOutlet weak var btnStarNum2: UIButton!
    @IBOutlet weak var btnStarNum3: UIButton!
    @IBOutlet weak var btnStarNum4: UIButton!
    @IBOutlet weak var btnStarNum5: UIButton!
    @IBOutlet weak var btnReviewRegister: UIButton!
        
    var grade = 0
    
    let uSeq = UserDefaults.standard.integer(forKey: "uSeqno")
    let prdSeq = UserDefaults.standard.integer(forKey: "prdSeqno")
    let subsSeq = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStarNum1.tag = 1
        btnStarNum2.tag = 2
        btnStarNum3.tag = 3
        btnStarNum4.tag = 4
        btnStarNum5.tag = 5
        btnReviewRegister.tag = 0
        
        let queryModel = prdDetailQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(prdSeqno: String(prdSeq), uSeqno: String(uSeq))
        
        // Do any additional setup after loading the view.
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        let item: prdDetailDBModel = feedItem[0] as! prdDetailDBModel
        lbKSHRvChannelName.text = (item.chNickName!)
        lbKSHRvChannelGrade.text = (item.chGrade!)
        lbKSHRvChannelSubs.text = (item.prdContext!)
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child("chImage").child(item.chImage!)
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                self.ivKSHRvChannelImage.image = UIImage(named: "emptyImage.png")
            } else {
                self.ivKSHRvChannelImage.image = UIImage(data: data!)
            }
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
    
    @IBAction func startBtnClicked(sender:UIButton) {
        let imgEmptyStar = UIImage(systemName: "star")
        let imgFullStar = UIImage(systemName: "star.fill")
        if sender.tag < 1 {
            let result = checkValue()
            if result {
                let rTitle = tfKSHReviewTitle.text!.trimmingCharacters(in: [" "])
                let rContent = trKSHReviewContent.text!.trimmingCharacters(in: [" "])
                let reviewAddqueryModel = ReviewAddQueryModel()
                reviewAddqueryModel.InsertReviewItems(rTitle: rTitle, rContent: rContent, rGrade: String(grade), subsSeq: String(subsSeq), uSeq: String(uSeq))
                
                myAlert(alertTitle: "결과", alertMessage: "리뷰가 등록되었습니다.", actionTitle: "OK", handler: { ACTION in
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
        } else {
            grade = sender.tag
            switch sender.tag {
            case 1:
                btnStarNum1.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum2.setImage(imgEmptyStar, for: UIControl.State.normal)
                btnStarNum3.setImage(imgEmptyStar, for: UIControl.State.normal)
                btnStarNum4.setImage(imgEmptyStar, for: UIControl.State.normal)
                btnStarNum5.setImage(imgEmptyStar, for: UIControl.State.normal)
                break
            case 2:
                btnStarNum1.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum2.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum3.setImage(imgEmptyStar, for: UIControl.State.normal)
                btnStarNum4.setImage(imgEmptyStar, for: UIControl.State.normal)
                btnStarNum5.setImage(imgEmptyStar, for: UIControl.State.normal)
                break
            case 3:
                btnStarNum1.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum2.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum3.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum4.setImage(imgEmptyStar, for: UIControl.State.normal)
                btnStarNum5.setImage(imgEmptyStar, for: UIControl.State.normal)
                break
            case 4:
                btnStarNum1.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum2.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum3.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum4.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum5.setImage(imgEmptyStar, for: UIControl.State.normal)
                break
            case 5:
                btnStarNum1.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum2.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum3.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum4.setImage(imgFullStar, for: UIControl.State.normal)
                btnStarNum5.setImage(imgFullStar, for: UIControl.State.normal)
                break
            default:
                break
            }
            
        }
    }
    
    func checkValue() -> Bool {
        var result = false
        if tfKSHReviewTitle.text!.trimmingCharacters(in: [" "]).isEmpty {
            myAlert(alertTitle: "확인 요청", alertMessage: "제목을 입력해주세요!", actionTitle: "OK", handler: nil)
        } else if trKSHReviewContent.text!.trimmingCharacters(in: [" "]).isEmpty {
            myAlert(alertTitle: "확인 요청", alertMessage: "내용을 입력해주세요!", actionTitle: "OK", handler: nil)
        } else if grade == 0 {
            myAlert(alertTitle: "확인 요청", alertMessage: "평점을 등록해주세요!", actionTitle: "OK", handler: nil)
        } else {
            result = true
        }
        return result
    }
    
    func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
        let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil)
    }
    
}
