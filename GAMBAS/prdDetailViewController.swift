//
//  prdDetailViewController.swift
//  GAMBAS
//
//  Created by sookjeon on 2020/09/17.
//  Copyright © 2020 TJ. All rights reserved.
//

import UIKit
import Firebase

class prdDetailViewController: UIViewController, prdDetailQueryModelProtocol {
    
    var container: ContainerViewController!
    var feedItem: NSArray = NSArray()
    let formatter = DateFormatter()
    
    
    
    var prdSeqno:String?
    let uSeqno: String = String(UserDefaults.standard.integer(forKey: "uSeqno"))
    
    @IBOutlet weak var btnSubs: UIButton!
    @IBOutlet weak var lblChName: UILabel!
    @IBOutlet weak var ivPrdImage: UIImageView!
    @IBOutlet weak var lblPrdPrice: UILabel!
    @IBOutlet weak var lblPrdName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let queryModel = prdDetailQueryModel()
        
        
        queryModel.delegate = self
        queryModel.downloadItems(prdSeqno: prdSeqno!, uSeqno: uSeqno)
        container!.segueIdentifierReceivedFromParent("second")
        
        
        formatter.dateFormat = "yyyy-MM-dd"
        
    }
    
    func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveItems(_ prdSeq:String){
        self.prdSeqno = prdSeq
    }
    
    func itemDownloaded(items: NSArray) {
        feedItem = items
        let item: prdDetailDBModel = feedItem[0] as! prdDetailDBModel
        lblChName.text = (item.chNickName)
        lblPrdName.text = (item.prdTitle)
        lblPrdPrice.text = (item.prdPrice)
        if(Int(item.uSeqCount!) != 0){
            btnSubs.isHidden = true
        }
        
        //Firebase image download
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child("prdImage").child(item.prdImage!)
        
        imgRef.getData(maxSize: 1 * 1024 * 1024) {data, error in
            if error != nil {
            } else {
                self.ivPrdImage.image = UIImage(data: data!)
            }
        }
        
    }
    
    
    @IBAction func btnSubs(_ sender: UIButton) {
        let current_date_string = formatter.string(from: Date())
        let checkAlert = UIAlertController(title: "구독 하시겠습니까?", message: "가격 : \(lblPrdPrice.text!)/월\n구독일자 : \(current_date_string)" , preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        checkAlert.addAction(onAction)
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
}
