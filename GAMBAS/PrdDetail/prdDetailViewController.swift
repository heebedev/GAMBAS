//
//  prdDetailViewController.swift
//  GAMBAS
//
//  Created by sookjeon on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class prdDetailViewController: UIViewController, prdDetailQueryModelProtocol, AddSubscribeQueryModelProtocol {
    
    var container: ContainerViewController!
    var feedItem: NSArray = NSArray()
    let formatter = DateFormatter()
    var chSeqno:String?
    var prdSeqno:String?
    let uSeqno: String = String(UserDefaults.standard.integer(forKey: "uSeqno"))
    let addSubscribeModel = AddSubscribeQueryModel()
    let queryModel = prdDetailQueryModel()
    
    
    @IBOutlet weak var btnSubs: UIButton!
    @IBOutlet weak var btnSubsCancel: UIButton!
    @IBOutlet weak var lblChName: UILabel!
    @IBOutlet weak var ivPrdImage: UIImageView!
    @IBOutlet weak var lblPrdPrice: UILabel!
    @IBOutlet weak var lblPrdName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        queryModel.delegate = self
        addSubscribeModel.delegate = self
        
        queryModel.downloadItems(prdSeqno: prdSeqno!, uSeqno: uSeqno)
        container!.segueIdentifierReceivedFromParent("second")
        
        btnSubsCancel.isHidden = true
        
        formatter.dateFormat = "yyyy-MM-dd"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveItems(_ prdSeq:String){
        self.prdSeqno = prdSeq
        
    }
    
    func addSubsResultDownloaded(result: Bool) {
        if result {
            
        } else {
            
        }
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        let item: prdDetailDBModel = feedItem[0] as! prdDetailDBModel
        lblChName.text = (item.chNickName)
        lblPrdName.text = (item.prdTitle)
        lblPrdPrice.text = (item.prdPrice)
        chSeqno = item.chSeqno
        if(Int(item.uSeqCount!)! > 0){
            btnSubs.isHidden = true
            btnSubsCancel.isHidden = false
        }
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child("prdImage").child(item.prdImage!)
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
                self.ivPrdImage.image = UIImage(named: "appstore.png")
            } else {
                self.ivPrdImage.image = UIImage(data: data!)
            }
        }
        
    }
    
    
    @IBAction func btnSubs(_ sender: UIButton) {
        let current_date_string = formatter.string(from: Date())
        let checkAlert = UIAlertController(title: "구독 하시겠습니까?", message: "가격 : \(lblPrdPrice.text!)/월\n구독일자 : \(current_date_string)" , preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { ACTION in
            self.addSubscribeModel.addSubscribeInsertloadItems(uSeqno: self.uSeqno, prdSeqno: self.prdSeqno!, code: "add")
            self.btnSubs.isHidden = true
            self.btnSubsCancel.isHidden = false
        })
        checkAlert.addAction(onAction)
        present(checkAlert, animated: true, completion: nil)
    }
    
    @IBAction func btnSubsCancel(_ sender: UIButton) {
        let checkAlert = UIAlertController(title: "확인", message: "구독을 취소하시겠습니까?" , preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { ACTION in
            self.addSubscribeModel.addSubscribeInsertloadItems(uSeqno: self.uSeqno, prdSeqno: self.prdSeqno!, code: "cancel")
            self.btnSubs.isHidden = false
            self.btnSubsCancel.isHidden = true
        })
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        checkAlert.addAction(onAction)
        checkAlert.addAction(cancelAction)
        present(checkAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            container!.segueIdentifierReceivedFromParent("second")
        }else{
            container!.segueIdentifierReceivedFromParent("first")
            
        }
    }
    
    
    //extension prdDetailViewController: UIScrollViewDelegate {
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        print("Current X,Y are X:\(scrollView.contentOffset.x), Y: \(scrollView.contentOffset.y)")
    //        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
    //        print("current page : \(currentPage)")
    //    }
    //}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = (segue.destination as! ContainerViewController)
            container.animationDurationWithOptions = (0.5, .transitionCrossDissolve)
        }
    }
    
    
    @IBAction func btnClose(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "prdSeqno")
        dismiss(animated: true, completion: nil)
    }
    
    
}
