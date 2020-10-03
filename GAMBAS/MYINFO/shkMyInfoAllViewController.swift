//
//  shkMyInfoAllViewController.swift
//  GAMBAS
//
//  Created by 신경환 on 2020/09/18.
//  Copyright © 2020 TJ. All rights reserved.MyLikeReviewableViewCell
//

import UIKit
import Firebase

class shkMyInfoAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyLikeListQueryModelProtocol, MyReviewListQueryModelProtocol, SKHmyInfoQueryModelProtocol {
    
    func myLikeDownloaded(likes: NSArray) {
        likeItems = likes
    }
    
    func myReviewDownloaded(reviews: NSArray) {
        reviewItems = reviews
    }
    
    func itemDownloaded(items: NSArray) {
        let item: SKHmyInfoModel = items[0] as! SKHmyInfoModel
        
        lbSKHName.text = item.ivSKHname
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgRef = storageRef.child("uImage").child(item.ivSKHimage!)
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                self.ivMyInfoProfile.image = UIImage(named: "emptyImage.png")
            } else {
                self.ivMyInfoProfile.image = UIImage(data: data!)
            }
        }
    }
    
    
    @IBOutlet weak var ivMyInfoProfile: UIImageView!
    @IBOutlet var lbSKHName: UILabel!
    @IBOutlet weak var tvMyLikeTableView: UITableView!
    @IBOutlet weak var tvMyReviewTableView: UITableView!
    @IBOutlet weak var btnRegistCreator: UIButton!
    
    
    
    
    
    var likeItems: NSArray = NSArray()
    var reviewItems:NSArray = NSArray()
    
    let uSeqno = String(UserDefaults.standard.integer(forKey: "uSeqno"))
    let uCRCode: Int = UserDefaults.standard.integer(forKey: "uCRCode")
    
    let likeQueryModel = MyLikeListQueryModel()
    let reviewQueryModel = MyReviewListQueryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvMyLikeTableView.delegate = self
        tvMyLikeTableView.dataSource = self
        tvMyLikeTableView.rowHeight = 68
        tvMyLikeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tvMyReviewTableView.delegate = self
        tvMyReviewTableView.dataSource = self
        tvMyReviewTableView.rowHeight = 68
        tvMyReviewTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        
        if uCRCode != 1 {
            btnRegistCreator.isHidden = true
        } else {
            btnRegistCreator.isHidden = false
        }
        
        likeQueryModel.delegate = self
        likeQueryModel.likeDownloadItems(uSeqno: uSeqno)
        
        reviewQueryModel.delegate = self
        reviewQueryModel.reviewDownloadItems(uSeqno: uSeqno)
        
        let queryModel = QueryModel()
        queryModel.delegate = self
        queryModel.downloadItems(seq: uSeqno)
        
        ivMyInfoProfile.layer.cornerRadius = 30
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        likeQueryModel.likeDownloadItems(uSeqno: uSeqno)
        reviewQueryModel.reviewDownloadItems(uSeqno: uSeqno)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        likeQueryModel.likeDownloadItems(uSeqno: uSeqno)
        reviewQueryModel.reviewDownloadItems(uSeqno: uSeqno)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        if tableView == tvMyLikeTableView{
            result = likeItems.count
        } else {
            result = reviewItems.count
        }
        return result
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeReviewCell", for: indexPath) as! LikeReviewTableViewCell
        if tableView == tvMyLikeTableView {
            let item: LikeReviewModel = likeItems[indexPath.row] as! LikeReviewModel
            cell.lbTitle.text = item.title
            cell.lbSubTitle.text = item.subTitle
        } else {
            let item: LikeReviewModel = reviewItems[indexPath.row] as! LikeReviewModel
            cell.lbTitle.text = item.title
            cell.lbSubTitle.text = item.subTitle
        }
        return cell
    }
    
    
    @IBAction func clickBtnRegistCreator(_ sender: UIButton) {
        let resultAlert = UIAlertController(title: "확인", message: "크리에이터로 등록하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { action in
            let creatorQueryModel = CreatorRegistQuaryModel()
            creatorQueryModel.registItems(uSeqno: self.uSeqno, uCreatorCode: "0")
            self.btnRegistCreator.isHidden = true
            self.myAlert(alertTitle: "완료", alertMessage: "등록되었습니다.", actionTitle: "확인", handler: {ACTION in
            })
            
        })
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        resultAlert.addAction(onAction)
        resultAlert.addAction(cancelAction)
        present(resultAlert, animated: true, completion: nil)
        
    }
    
    func myAlert(alertTitle: String, alertMessage: String, actionTitle: String, handler:((UIAlertAction) -> Void)?) {
        let resultAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler)
        resultAlert.addAction(onAction)
        present(resultAlert, animated: true, completion: nil)
    }
}
